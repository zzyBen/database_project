class AddTableBookingRelation < ActiveRecord::Migration[5.1]
  def change
    add_reference :bookings, :table
  end
end
