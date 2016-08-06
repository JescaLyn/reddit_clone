class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user, :logged_in?

  def current_user
    @current_user ||= User.find_by(session_token: session[:session_token])
  end

  def login_user!(user)
    user.reset_session_token!
    session[:session_token] = user.session_token
    redirect_to subs_url
  end

  def logout_user!
    current_user.reset_session_token!
    session[:session_token] = nil
    @current_user = nil
    redirect_to new_session_url
  end

  def logged_in?
    current_user ? true : false
  end

  def ensure_current_user
    redirect_to new_session_url unless current_user
  end
end
