class Table < ApplicationRecord

  has_many :seats, dependent: :destroy

  validates :floor, presence: true
  
  validates :zone,  presence: true
  
  validates :with_window, presence: true
  
  validates :with_charge, presence: true
  
  validates :table_number, presence: true, uniqueness: true
  
  
  
  def Table.floor_range
    [1, 2, 3]
  end
  
  def Table.zone_range
    ["Ease", "West", "North", "South"]
  end
  
  def Table.with_window_range
    [true, false]
  end
  
  def Table.with_charge_range
    [true, false]
  end



end
