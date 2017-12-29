class AddTableSeatRelation < ActiveRecord::Migration[5.1]
  def change
    add_reference :seats, :table
  end
end
