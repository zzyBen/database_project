class CreateChecks < ActiveRecord::Migration[5.1]
  def change
    create_table :checks do |t|
      t.string :floor
      t.string :zone
      t.string :with_charge
      t.string :with_window
      t.string :timestart
      t.string :timeend
      t.boolean :confirmation

      t.timestamps
    end
  end
end
