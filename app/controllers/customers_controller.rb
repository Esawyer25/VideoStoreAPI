class CustomersController < ApplicationController
  #protect_from_forgery with: :null_session

  def index
    customers = Customer.all
    render(
      json: customers.as_json(only: [:id, :name, :registered_at, :postal_code, :phone, :movies_checked_out_count]),
      status: :ok
    )
  end

end
