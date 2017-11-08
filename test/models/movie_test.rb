require "test_helper"

describe Movie do

describe "validations" do
  before do
    @movie = movies(:Jaws)
  end

  it "should be valid" do
    @movie.must_be :valid?
  end

  it "should not be valid without a title" do
    @movie.title = nil
    @movie.wont_be :valid?
  end
end

describe "decrease_inventory" do
  it "should return an Integer if there is available inventory" do
    movie = movies(:Psych)
    current_inventory = movie.available_inventory

    movie.decrease_inventory.must_equal current_inventory - 1
  end

  it "should return nil if there is not available inventory" do
    movie = movies(:Psych)
    movie.available_inventory = 0

    movie.decrease_inventory.must_equal nil
  end
end

end
