class CustomersController < ApplicationController
  #protect_from_forgery with: :null_session

  def index
    customers = Customer.all
    render(
    json: customers, status: :ok
    )
  end

end
