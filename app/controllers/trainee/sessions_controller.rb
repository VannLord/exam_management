class Trainee::SessionsController < TrainerController
  def after_sign_in_path_for(resource)
    user_exams_path
  end
end
