require File.expand_path(File.join(File.dirname(__FILE__), '..', 'spec', 'setup', 'spec_helper.rb'))

describe RottenList do

  it "should lookup a movie list and return an array" do
    movies = RottenList.find(:type => "upcoming", :limit => 3)
    movies.should be_a_kind_of Array
    movies.each do |movie|
      movie.should be_a_kind_of OpenStruct
    end    
  end
  
  it "should raise an error when a lookup type that is not recognized is used" do
    lambda {
      movies = RottenList.find(:type => "unknown", :limit => 3)
    }.should raise_error(ArgumentError)
  end

end
