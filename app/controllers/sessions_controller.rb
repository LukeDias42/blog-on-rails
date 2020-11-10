class SessionsController < ApplicationController

  before_action :require_no_log_in, only: [:new, :create]

  def new

  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      flash[:notice] = "Logged in succesfully"
      redirect_to user
    else
      flash.now[:alert] = "Email or password were not found!"
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "Logged out"
    redirect_to root_path
  end

  private
  def require_no_log_in
    if logged_in?
      flash[:alert] = "You have already logged in"
      redirect_to current_user
    end
  end

end