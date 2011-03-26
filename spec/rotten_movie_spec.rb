require File.expand_path(File.join(File.dirname(__FILE__), '..', 'spec', 'setup', 'spec_helper.rb'))

describe RottenMovie do

  describe "searching" do

    it "should create an empty array for searches with no results" do
      movie = RottenMovie.find("xxxxxx")
      movie.should == []
    end

    it "should require a search term" do
      lambda {
        RottenMovie.find()
      }.should raise_error(ArgumentError)
    end

    it "should return an array of movies" do
      movies = RottenMovie.find("Fight Club")
      movies.should be_a_kind_of Array
      movies.each do |movie|
        movie.should be_a_kind_of OpenStruct
      end
    end

    it "should return a single movie when limit=1" do
      movie = RottenMovie.find("Fight Club", :limit => 1)
      movie.should be_a_kind_of OpenStruct
    end

    it "should show movies found with the same data as equal" do
      movie1 = RottenMovie.find("Fight Club", :limit => 1)
      movie2 = RottenMovie.find("Fight Club", :limit => 1)
      movie1.should == movie2
    end

    it "should return an array of X movies when limit=X" do
      movies = RottenMovie.find("Fight Club", :limit => 3)
      movies.should be_a_kind_of Array
      movies.length.should == 3
      movies.each do |movie|
        movie.should be_a_kind_of OpenStruct
      end
    end

    it "should raise an exception if limit is smaller than 1" do
      [-100, 0].each do |limit|
        lambda {
          RottenMovie.find("Fight Club", :limit => limit)
        }.should raise_error(ArgumentError)
      end
    end

    it "should raise an exception if limit is not a integer" do
      [1.1, "1.1", [1], "one"].each do |limit|
        lambda {
          RottenMovie.find("Fight Club", :limit => limit)
        }.should raise_error(ArgumentError)
      end
    end

  end

end
