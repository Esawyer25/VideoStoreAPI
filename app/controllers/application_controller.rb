class ApplicationController < ActionController::API

  def index
    render(
      json: {text: "it works!"}
      )
  end

end
