class ApplicationController < ActionController::Base
  
  helper_method :current_user, :logged_in?

  def current_user
    #If there is a current user, it simply returns it, else it finds the current user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    #!! returns a boolean
    !!current_user
  end

  def require_user
    if !logged_in?
      flash[:alert] = "You must be logged in to perform that action"
      redirect_to login_path
    end
  end

end
