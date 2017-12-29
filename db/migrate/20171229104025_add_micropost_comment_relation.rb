class AddMicropostCommentRelation < ActiveRecord::Migration[5.1]
  def change
    add_reference :comments, :micropost
    add_reference :comments, :user
  end
end
