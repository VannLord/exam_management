class Supervisor::SubjectsController < SupervisorController
  before_action :find_subject, only: [:show, :edit, :destroy, :update]
  before_action :redirect_if_not_admin
  def index
    @subjects = Subject.paginate(page: params[:page])
  end

  def new
    @subject = Subject.new
  end

  def show; end

  def create
    @subject = Subject.new(subject_params)
    if @subject.save
      byebug
      flash[:success] = "Create sucessful"
      redirect_to subjects_path
    else
      render :edit
    end
  end

  def edit; end

  def update
    if @subject.update(subject_params)
      flash[:success] = "Subject updated"
      redirect_to subjects_path
    else
      render :edit
    end
  end

  def destroy
    @subject.destroy
    flash[:success] = "Subject deleted"
    redirect_to subjects_path
  end

  private

  def subject_params
    params.require(:subject).permit(:name)
  end

  def redirect_if_not_admin
    redirect_to root_path unless current_user.supervisor?
  end

  def find_subject
    @subject = Subject.find_by(id: params[:id])
  end
end
