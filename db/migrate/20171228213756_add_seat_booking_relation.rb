class AddSeatBookingRelation < ActiveRecord::Migration[5.1]
  def change
    add_reference :bookings, :seat
  end
end
