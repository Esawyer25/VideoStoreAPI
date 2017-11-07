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

end
