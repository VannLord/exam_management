class Supervisor::QuestionsController < SupervisorController
  before_action :load_subject, :load_file_param, :correct_file_type,
                only: :create_list
  before_action :find_question, only: :destroy
  load_and_authorize_resource

  def index
    @questions = @questions.sort_by_created_at_desc
                           .paginate(page: params[:page])
                           .per_page(Settings.page)
  end

  def destroy
    @question.destroy!
    flash[:success] = t "questions.deleted"
    redirect_to questions_path
   rescue ActiveRecord::ActiveRecordError
    flash[:danger] = t "questions.deleted_failed"
    redirect_to questions_path

  end

  def new_list
    @subjects = Subject.sort_by_created_at_desc
  end

  def create_list
    FileService.read_questions_from_file!(@file_path, @subject, params[:list_questions][:exam_name])
    flash[:success] = t "questions.create_list_success"
    redirect_to exams_path
  rescue ActiveRecord::ActiveRecordError
    flash[:danger] = t "questions.create_list_fail"
    redirect_to new_list_questions_path
  end

  private

  def load_subject
    @subject = Subject.find_by id: params[:subject].to_i
    return if @subject

    flash[:danger] = t "questions.choice_subject!"
    redirect_to new_list_questions_path
  end

  def load_file_param
    @file_param = params["file"]
    return if @file_param

    flash[:danger] = t "questions.please_choice_file!"
    redirect_to new_list_questions_path
  end

  def correct_file_type
    @file_path = @file_param.tempfile.to_path.to_s
    return if @file_path.end_with?(".xlsx") || @file_path.end_with?(".xls")

    flash[:danger] = t "questions.please_choice_correct_file_type!"
    redirect_to new_list_questions_path
  end

  def find_question
    @question = Question.find_by(id: params[:id])
  end
end
