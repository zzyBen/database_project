class CreateTables < ActiveRecord::Migration[5.1]
  def change
    create_table :tables do |t|
      t.integer :table_number
      t.integer :floor
      t.string :zone
      t.boolean :with_window
      t.boolean :with_charge

      t.timestamps
    end
  end
end
