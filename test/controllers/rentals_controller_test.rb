require "test_helper"

describe RentalsController do

  describe "create" do

    let(:rental_data) {
      {
        due_date: "2016-02-12",
        customer_id: Customer.first.id,
        movie_id: Movie.first.id
      }
    }

    it "should create a new rental when given valid data" do
      proc {
        post rental_checkout_path, params: rental_data}.must_change 'Rental.count', 1

        must_respond_with :success
    end

    it "should increase the customer movies_checked_out_count by 1" do
      customer_id = rental_data[:customer_id]
      customer = Customer.find_by(id: customer_id)

      count = customer.movies_checked_out_count

      post rental_checkout_path, params: rental_data
      customer.reload

      customer.movies_checked_out_count.must_equal count + 1
    end

    it "should decrease the movie available_inventory by 1" do
      movie_id = rental_data[:movie_id]
      movie = Movie.find_by(id: movie_id)

      count = movie.available_inventory

      post rental_checkout_path, params: rental_data

      movie.reload

      movie.available_inventory.must_equal count - 1
    end

    it "should return bad_request if not enough available_inventory" do

    end

    it "should not change the database if given invalid data" do
      invalid_rental_data = {
        due_date: "2016-02-12",
      }

      proc {
        post rental_checkout_path, params: {rental: invalid_rental_data}}.wont_change 'Rental.count'

        must_respond_with :bad_request

        body = JSON.parse(response.body)
        body.must_equal "errors"=>{"movie"=>["must exist"], "customer"=>["must exist"]}
    end
  end

  describe "update" do
    before do
      @rental = rentals(:one)
      @valid_data = {
        customer_id: @rental.customer_id,
        movie_id: @rental.movie_id,
        due_date: @rental.due_date
      }
    end

    it "should respond with success when given valid data" do
      patch rental_checkin_path, params: {rental: @valid_data}

      must_respond_with :success
    end

    it "should change due_date to nil when given valid data" do
      patch rental_checkin_path, params: @valid_data
      rental = Rental.find_by(id: @rental.id)
      @rental.reload
      assert_nil @rental.due_date
      # assert_nil rental.due_date
    end

    it "should returns the right information" do
      patch rental_checkin_path, params: @valid_data
      body = JSON.parse(response.body)
      body["id"].must_equal @rental.id
    end

    it "should decrease the customer's movies_checked_out_count by 1" do
      checked_out_count = @rental.customer.movies_checked_out_count

      patch rental_checkin_path, params: @valid_data
      @rental.reload

      @rental.customer.movies_checked_out_count.must_equal checked_out_count - 1
    end

    it "should increase the movie's available_inventory by 1" do
      current_inventory = @rental.movie.available_inventory

      patch rental_checkin_path, params: @valid_data
      @rental.reload

      @rental.movie.available_inventory.must_equal current_inventory + 1
    end

    it "should " do

    end
  end
end
