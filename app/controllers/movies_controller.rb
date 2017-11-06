class MoviesController < ApplicationController

  def index
    movies = Movie.all

    render(
    json: movies.as_json(only: [:id, :title, :release_date]), status: :ok
    )
  end

  def show
    movie = Movie.find_by(id: params[:id])

    if movie
      render(
      json: movie.as_json(only: [:id, :title, :release_date]), status: :ok
      )
    else
      render(
      json: {nothing: true}, status: :not_found
      )
    end
  end
end
