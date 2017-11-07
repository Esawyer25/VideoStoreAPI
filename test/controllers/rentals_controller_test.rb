require "test_helper"

describe RentalsController do

  describe "create" do

    let(:rental_data) {
      {
        due_date: "2016-02-12",
        customer_id: Customer.first.id,
        movie_id: Movie.first.id,
      }
    }

    it "should create a new rental when given valid data" do

      proc {
        post rental_checkout_path, params: rental_data}.must_change 'Rental.count', 1

        must_respond_with :success
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
      rental = rentals(:one)
      @valid_data = {
        customer_id: rental.customer_id,
        movie_id: rental.movie_id
      }
    end

    it "should respond with success when given valid data" do
      patch rental_checkin_path, params: {rental: @valid_data}

      must_respond_with :success
    end

    it "should change due_date to nil when given valid data" do
      patch rental_checkin_path, params: {rental: @valid_data}


    end
  end
end
