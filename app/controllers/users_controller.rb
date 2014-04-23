class UsersController < ApplicationController
  before_action :signed_in_user, only: [:index, :edit, :update]
  #before you edit or update or view the users index, you must call the signed_in_user method
  before_action :correct_user,   only: [:edit, :update]
  #before you edit or update, you must call the correct_user method
  before_action :admin_user,     only: :destroy
  #only admin users can delete users
  def show
    @user = User.find(params[:id])
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)    # Not the final implementation!
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end
  
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted."
    redirect_to users_url
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)  #if the update was indeed successful
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  def index
    @users = User.paginate(page: params[:page])
  end
  
  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
  end
  
  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
  
  def correct_user
    @user = User.find(params[:id])  #looks up the user ID
    redirect_to(root_url) unless current_user?(@user)  #current user must equal @user as defined above
  end
  
  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end
end