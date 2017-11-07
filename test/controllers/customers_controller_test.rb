require "test_helper"

describe CustomersController do
  describe "index" do
    # These tests are a little verbose - yours do not need to be
    # this explicit.
    it "is a real working route" do
      get customers_path
      must_respond_with :success
    end

    it "should return json" do
      get customers_path
      response.header['Content-Type'].must_include 'json'
    end

    it "should return an Array" do
      get customers_path

      body = JSON.parse(response.body)
      body.must_be_kind_of Array
    end

    it "should return all customers" do
      get customers_path

      body = JSON.parse(response.body)
      body.length.must_equal Customer.count
    end

    it "should return customers with exactly the required data" do
      keys = %w(id movies_checked_out_count name phone postal_code registered_at)

      get customers_path
      body = JSON.parse(response.body)
      body.each do |cust|
        cust.keys.sort.must_equal keys
      end
    end

    it "returns an empty array if there are no customer" do
      Customer.destroy_all
      get customers_path

      must_respond_with :success
      body = JSON.parse(response.body)
      body.must_be_kind_of Array
      body.must_be :empty?
    end
  end


end
