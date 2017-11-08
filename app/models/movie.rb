class Movie < ApplicationRecord
  has_many :rentals
  validates :title, presence: true

  def increase_inventory
    self.available_inventory += 1
  end

  def decrease_inventory
    if available_inventory?
      self.available_inventory -= 1
    end
  end

  private

  def available_inventory?
    unless self.available_inventory < 1
      return true
    end
  end
end
