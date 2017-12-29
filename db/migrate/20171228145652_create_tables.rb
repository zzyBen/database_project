class CreateTables < ActiveRecord::Migration[5.1]
  def change
    create_table :tables do |t|
      t.integer :table_number
      t.string :floor
      t.string :zone
      t.string :with_window
      t.string :with_charge

      t.timestamps
    end
  end
end
