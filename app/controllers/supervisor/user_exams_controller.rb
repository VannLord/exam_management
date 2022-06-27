class Supervisor::UserExamsController < SupervisorController
  before_action :load_trainee, only: [:index, :show]
  before_action :correct_user, only: :show
  load_and_authorize_resource

  def index
    @user_exams = @trainee.user_exams
                          .sort_by_created_at_desc
                          .includes({exam: :exam_questions}, :subject)
                          .paginate(page: params[:page])
                          .per_page(Settings.page)
  end

  def show
    begin
      @user_exam.testing! if @user_exam.start?
    rescue ActiveRecord::ActiveRecordError
      flash[:danger] = t("user_exams.try_again")
      redirect_to user_exams_path
    end
    @user_answer_ids = @user_exam.answers.pluck(:id)
    @total = @user_exam.questions.reduce(0) do |sum, q|
      sum + 10
    end

  end

  private

  def load_trainee
    @trainee = User.find_by id: params[:trainee_id]
    return if @trainee

    flash[:danger] = t "trainees.not_found!"
    redirect_to root_path
  end

  def correct_user
    @user_exam = @trainee.user_exams.find_by id: params[:id]
    return if @user_exam

    flash[:danger] = t("user_exams.not_found!")
    redirect_back(fallback_location: user_exams_path)
  end
end
