class Customer < ApplicationRecord
  has_many :rentals
  has_many :movies, through: :rentals

  def increase_movies_checked_out_count
    #handle overdue if you get there
    self.movies_checked_out_count += 1
  end
end
