class Supervisor::UsersController < SupervisorController
  authorize_resource
  before_action :authenticate_user!
  before_action :load_user, only: [:show, :edit, :update, :destroy]

  def trainees_index
    @q = User.ransack(params[:q])
    @trainees = @q.result.trainee.sort_by_created_at_asc
                  .includes(:user_exams)
                  .page(params[:page]).per_page(Settings.page)
  end

  def supervisors_index
    @q = User.ransack(params[:q])
    @supervisors = @q.result.supervisor.sort_by_created_at_desc
                     .page(params[:page]).per_page(Settings.page)
  end

  def destroy
    if @user.destroy
      flash[:sucess] = t "user_deleted"
    else
      flash[:danger] = t "delete_fail"
    end
    redirect_to trainees_users_path
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      flash[:info] = t "users.created_success"
      redirect_to trainees_users_path
    else
      render :new
    end
  end

  def show; end
  def edit; end

  def update
    if @user.update(user_params)
      flash[:sucess] = t "users.profile_updated"
      redirect_to trainees_users_path
    else
      render :edit
    end
  end
  private

  def load_user
    @user = User.find_by id: params[:id]
    return if @user

    flash[:danger] = t "index.nil_user"
    redirect_to root_path
  end

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation)
  end

end
