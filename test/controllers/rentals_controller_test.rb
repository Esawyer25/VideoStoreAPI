require "test_helper"

describe RentalsController do

  describe "create" do

    let(:rental_data) {
      {
        due_date: "2016-02-12",
        customer_id: 1,
        movie_id: 1,
      }
    }

    #TODO: failing!
    it "should create a new rental when given valid data" do

      proc {
        post rentals_path, params: {rental: rental_data}}.must_change 'Rental.count', 1

        must_respond_with :success
    end

    it "should not change the database if given invalid data" do
      invalid_rental_data = {
        due_date: "2016-02-12",
      }

      proc {
        post rentals_path, params: {rental: invalid_rental_data}}.wont_change 'Rental.count'

        must_respond_with :bad_request

        body = JSON.parse(response.body)
        body.must_equal "errors"=>{"movie"=>["must exist"], "customer"=>["must exist"]}
    end
  end

  describe "update" do
    before do
      @rental = rentals(:one)
    end

    it "should update rental when given valid data" do
      rental_id = @rental.id
      patch rental_path(rental_id)

      must_respond_with :success
    end
  end
end
