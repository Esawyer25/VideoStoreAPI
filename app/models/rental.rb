class Rental < ApplicationRecord
  belongs_to :movie
  belongs_to :customer

  def checkout_date
    return self.created_at.strftime("%d %b. %Y")
  end
end
