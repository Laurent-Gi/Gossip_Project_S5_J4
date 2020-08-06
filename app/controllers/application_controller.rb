class ApplicationController < ActionController::Base
  include SessionsHelper


# A mettre également dans un helper !
  def authenticate_user
    unless current_user
      flash[:danger] = "Merci de vous connecter"
      redirect_to new_session_path
    end
  end

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  helper_method :current_user

end
