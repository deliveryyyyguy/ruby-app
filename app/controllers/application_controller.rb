class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # Available to all the controllers but now views by default
  protect_from_forgery with: :exception

  #Helper is the current user logged in?
  helper_method :current_user, :logged_in?

  #find the current users session by his/her user_id
  def current_user
  	@current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  #Is the current user logged in?
  def logged_in?
  	!!current_user
  end

  #Require the user to be logged in
  def require_user
  	if !logged_in?
  		flash[:danger] = "You must be logged in to do that"
  		redirect_to root_path
  	end
  end
end
