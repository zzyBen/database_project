class CommentsController < ApplicationController

  def new
    @@micropost_id = params[:id]
    @comment = current_user.comments.build
  end
  
  
  def create
    @comment = current_user.comments.build(comment_params)
    @comment.micropost_id = @@micropost_id
    @user = Micropost.find(@@micropost_id).user
    if @comment.save
      # Handle a successful save.
      
      flash[:success] = "Posted comment successfully!"
      redirect_to @user
    else
      flash[:danger] = "Posted comment unsuccessfully"
      render 'new'
    end
  end
  
  
  def destroy
    user = Micropost.find(Comment.find(params[:id]).micropost_id).user
    Comment.find(params[:id]).destroy
    flash[:success] = "Comment destroyed."
    redirect_to user_path(user)
  end
  
  
  
########### private ###########  
  private  
  
    def comment_params                         # strong parameter
      params.require(:comment).permit(:content)
    end

end
