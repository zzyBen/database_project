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
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'    
    end
  end
  
  
  
  private
  
    def user_params                         # strong parameter
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
  
  
end
