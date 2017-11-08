class RentalsController < ApplicationController

  def create
    rental = Rental.new(rental_params)
    if rental.save
      render(
      json: {id: rental.id}, status: :ok
      )

      customer = Customer.find_by(id: rental.customer_id)
      customer.movies_checked_out_count += 1

      movie = Movie.find_by(id: rental.movie_id)
      movie.available_inventory -= 1
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
      render(
      json: {id: rental.id}, status: :ok
      )

      customer = Customer.find_by(id: rental.customer_id)
      customer.movies_checked_out_count -= 1

      movie = Movie.find_by(id: rental.movie_id)
      movie.available_inventory += 1
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
