class AddIndexToTableNumber < ActiveRecord::Migration[5.1]
  def change
      add_index :tables, :table_number, unique: true
  end
end
