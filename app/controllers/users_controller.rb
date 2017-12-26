class UsersController < ApplicationController

  before_action :signed_in_user,  only: [:index, :edit, :update, :destroy]
  before_action :correct_user,    only: [:edit, :update]
  before_action :admin_user,      only: :destroy
  
  def index
    #@users = User.all
    @users = User.paginate(page: params[:page])
  end
  

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
  end




  def new
    @user = User.new
  end
  
  
  
  
  def create
    #@user = User.new(params[:user])       # Not the final implementation!
    @user = User.new(user_params)
    if @user.save
      # Handle a successful save.
      sign_in @user
      flash[:success] = "Signing up successfully!"
      redirect_to @user
    else
      flash[:danger] = "Signing up unsuccessfully"
      render 'new'
    end
  end
  
  
  
  
  def edit
    #@user = User.find(params[:id])
    # done by before_cation correct_user
  end
  
  
  def update
    #@user = User.find(params[:id])
    # done by before_cation correct_user
    
    if @user.update_attributes(user_params)
      # Handle a successful update.
      flash[:success] = "Profile updated"
      sign_in @user
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed."
    redirect_to users_path
  end
  
  
  
########### private ###########  
  private
  
    def user_params                         # strong parameter
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
  
    ##### Before filters #####
  

    
    
    def correct_user
      @user = User.find(params[:id])
      unless current_user?(@user)
        redirect_to root_path
      end
    end
    
   

    
end
