class RentalsController < ApplicationController

  def create
    rental = Rental.new(rental_params)
    if rental.save
      render(
      json: {id: rental.id}, status: :ok
      )
    else
      render(
      json: {errors: rental.errors.messages}, status: :bad_request
      )
    end

  end

  def update
  end

  private
  def rental_params
    params.permit(:customer_id, :movie_id, :due_date)
  end


end
