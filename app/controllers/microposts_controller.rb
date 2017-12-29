class MicropostsController < ApplicationController
  before_action :signed_in_user, only: [:new, :create, :destroy]
  before_action :correct_user,   only: [:destroy]


  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:success] = "New micropost posted!"
      redirect_to current_user
    else
      flash[:danger] = "Invalid micropost!"
      render 'new'
    end
  end
  

  def new
    @micropost = current_user.microposts.build
  end


  def destroy
    Micropost.find(params[:id]).destroy
    flash[:success] = "Micropost destroyed."
    redirect_to user_path(current_user)
  end
  
########### private ########### 
    private
  
    def micropost_params                         # strong parameter
      params.require(:micropost).permit(:content)
    end


    def correct_user
      @user = Micropost.find(params[:id]).user
      unless current_user?(@user)
        redirect_to root_path
      end
    end

end
