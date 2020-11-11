class UsersController < ApplicationController

  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :require_user, except: [:show, :index, :new, :create]
  before_action :require_same_user, only: [:edit, :update, :destroy]
  before_action :require_no_log_in, only: [ :new, :create]


  def show
    @articles = @user.articles.paginate(page: params[:page], per_page: 5).order("created_at DESC")
  end

  def index
    @users = User.paginate(page: params[:page], per_page: 5)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "You signed up succesfully!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:notice] = "Profile was updated succesfully!"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    current_user.destroy
    session[:user_id] = nil
    flash[:notice] = "Account and all associated articles have been deleted"
    redirect_to root_path
  end

  private
  def set_user
    @user = current_user #User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

  def require_same_user
    if current_user !=  @user
      flash[:alert] = "You can only edit your own profile information!"
      redirect_to @user
    end
  end

  def require_no_log_in
    if logged_in?
      flash[:alert] = "You have already logged in"
      redirect_to current_user
    end
  end
      
end