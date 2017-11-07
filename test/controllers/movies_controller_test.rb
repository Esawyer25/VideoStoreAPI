require "test_helper"

describe MoviesController do
  describe "index" do
    # These tests are a little verbose - yours do not need to be
    # this explicit.
    it "is a real working route" do
      get movies_path
      must_respond_with :success
    end

    it "should return json" do
      get movies_path
      response.header['Content-Type'].must_include 'json'
    end

    it "should return an Array" do
      get movies_path

      body = JSON.parse(response.body)
      body.must_be_kind_of Array
    end

    it "should return all movies" do
      get movies_path

      body = JSON.parse(response.body)
      body.length.must_equal Movie.count
    end

    it "should return movies with exactly the required data" do
      keys = %w(id release_date title)

      get movies_path
      body = JSON.parse(response.body)
      body.each do |movie|
        movie.keys.sort.must_equal keys
      end
    end

    it "returns an empty array if there are no movies" do
      Movie.destroy_all
      get movies_path

      must_respond_with :success
      body = JSON.parse(response.body)
      body.must_be_kind_of Array
      body.must_be :empty?
    end
  end

  describe "show" do
    it "can get a specific movie" do
      get movie_path(movies(:Jaws).id)
      must_respond_with :success
    end

    it "responds correctly when movie is not found" do
      invalid_movie_id = Movie.all.last.id + 1
      get movie_path(invalid_movie_id)
      must_respond_with :not_found
      body = JSON.parse(response.body)
      body.must_equal "nothing" => true
    end

    it "returns the right information" do
      get movie_path(movies(:Jaws).id)
      body = JSON.parse(response.body)
      body["title"].must_equal "Jaws"
      body["release_date"].must_equal "1975-06-19"
      body["inventory"].must_equal 6
      body["overview"].must_equal "SHARKS"
      body["available_inventory"].must_equal 6
    end
  end

  describe "create" do
    let(:movie_data) {
      {
        title: "movie title",
        release_data: 1999-10-10,
        inventory: 10
      }
    }

    it "should create a movie" do
      proc {
        post movies_path, params: {movie: movie_data}}.must_change 'Movie.count', 1

        must_respond_with :success
      end

      it "should not change the database if the title is missing" do
        invalid_movie_data = {
          release_data: 1999-10-10,
          inventory: 10
        }

        proc {
          post movies_path, params: {movie: invalid_movie_data}}.wont_change 'Movie.count'

          must_respond_with :bad_request

          body = JSON.parse(response.body)
          body.must_equal "errors" => {"title" => ["can't be blank"]}
        end




      end
    end
