class MoviesController < ApplicationController

  def index
    movies = Movies.all

    render(
    json: movies.as_json(only: [:id, :title, :release_date]), status: :ok
    )
  end


  id
  name
  registered_at
  postal_code
  phone
  movies_checked_out_count
end
