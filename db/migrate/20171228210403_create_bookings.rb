class CreateBookings < ActiveRecord::Migration[5.1]
  def change
    create_table :bookings do |t|
      t.integer :user_id
      t.string :timestart
      t.string :timeend
      
      t.timestamps
    end
  end
end
