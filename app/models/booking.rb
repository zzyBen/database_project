class Booking < ApplicationRecord

validates :timestart, presence: true

validates :timeend, presence: true

belongs_to :seat

default_scope -> { order('timestart ASC') }





  def Booking.time_range
    (7..22).to_a
  end

  def Booking.true_range
    [1..2].to_a
  end

end
