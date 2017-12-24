class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
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
  
  
  
  private
  
    def user_params                         # strong parameter
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
  
  
end
