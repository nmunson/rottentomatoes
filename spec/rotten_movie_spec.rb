require File.expand_path(File.join(File.dirname(__FILE__), '..', 'spec', 'setup', 'spec_helper.rb'))

describe RottenMovie do

  it "should allow movies to be reloaded by their raw_data" do
    lambda {
      movie = RottenMovie.find(:title => "Fight Club", :limit => 1)
      RottenMovie.new(movie.raw_data)
    }.should_not raise_error
  end

  describe "searching" do

    it "should create an empty array for searches with no results" do
      movie = RottenMovie.find(:title => "xxxxxx")
      movie.should == []
    end

    it "should require a search term" do
      lambda {
        RottenMovie.find()
      }.should raise_error(ArgumentError)
    end

    it "should return an array of movies when searching by title" do
      movies = RottenMovie.find(:title => "Fight Club")
      movies.should be_a_kind_of Array
      movies.each do |movie|
        movie.should be_a_kind_of OpenStruct
      end

      movies = RottenMovie.find(:title => "Eternal Sunshine")
      movies.should be_a_kind_of Array
      movies.each do |movie|
        movie.should be_a_kind_of OpenStruct
      end
    end

    it "should return a single movie when limit=1 and searching by title" do
      movie = RottenMovie.find(:title => "Fight Club", :limit => 1)
      movie.should be_a_kind_of OpenStruct
    end

    it "should return a single movie when searching by id" do
      movie = RottenMovie.find(:id => 13153)
      movie.should be_a_kind_of OpenStruct
    end

    it "should return a single movie when searching by imdb id" do
      movie = RottenMovie.find(:imdb => 137523)
      movie.should be_a_kind_of OpenStruct
    end

    it "should return the full movie data when searching by id" do
      movie = RottenMovie.find(:id => 13153)
      movie.mpaa_rating.should == "R"
    end

    it "should return the full movie data when searching by imdb id" do
      movie = RottenMovie.find(:imdb => 137523)
      movie.mpaa_rating.should == "R"
    end

    it "should return the full movie data when expand_results set to true and searching by title" do
      movie = RottenMovie.find(:title => "Fight Club", :limit => 1, :expand_results => true)
      movie.mpaa_rating.should == "R"
      movie.abridged_cast.should_not be_nil
    end

    it "should show movies found with the same data as equal" do
      movie1 = RottenMovie.find(:title => "Fight Club", :limit => 1)
      movie2 = RottenMovie.find(:title => "Fight Club", :limit => 1)
      movie1.should == movie2
    end

    it "should return an array of X movies when limit=X" do
      movies = RottenMovie.find(:title => "Fight Club", :limit => 3)
      movies.should be_a_kind_of Array
      movies.length.should == 3
      movies.each do |movie|
        movie.should be_a_kind_of OpenStruct
      end
    end

    it "should raise an exception if limit is smaller than 1" do
      [-100, 0].each do |limit|
        lambda {
          RottenMovie.find(:title => "Fight Club", :limit => limit)
        }.should raise_error(ArgumentError)
      end
    end

    it "should raise an exception if limit is not a integer" do
      [1.1, "1.1", [1], "one"].each do |limit|
        lambda {
          RottenMovie.find(:title => "Fight Club", :limit => limit)
        }.should raise_error(ArgumentError)
      end
    end

  end

end
