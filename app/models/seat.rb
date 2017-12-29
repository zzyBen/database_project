class Seat < ApplicationRecord

  #has_many :bookings, dependent: :destroy
  
  belongs_to :table
  
  default_scope -> { order('seat_number ASC') }
  
  validates :seat_number, presence: true, uniqueness: true
  
  has_many :bookings, dependent: :destroy
  

  
end
