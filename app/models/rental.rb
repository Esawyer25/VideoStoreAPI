class Rental < ApplicationRecord
  has_one :movie
  has_one :customer
end
