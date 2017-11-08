class RentalsController < ApplicationController

  def create
    rental = Rental.new(rental_params)

    # debugger

    if rental.save
      rental.movie.decrease_inventory
      rental.customer.increase_movies_checked_out_count

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
    # puts "rental: #{params[:rental]}"
    # puts "customer_id: #{params[:customer_id]}"
    # puts "movie_id: #{params[:movie_id]}"
    rental = Rental.where(rental_params).first

    if rental
      rental.due_date = nil
      rental.customer.movies_checked_out_count -= 1
      rental.movie.available_inventory += 1

      rental.save

      render(
      json: {id: rental.id}, status: :ok
      )

    else
      render(
      json: {errors: rental.errors.messages}, status: :bad_request
      )
    end
  end

  private
  def rental_params
    params.permit(:customer_id, :movie_id, :due_date)
  end


end
