class Supervisor::SessionsController < SupervisorController
  def after_sign_in_path_for(resource)
    trainees_users_path
  end
end
