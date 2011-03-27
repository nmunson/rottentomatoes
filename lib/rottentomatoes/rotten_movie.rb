module RottenTomatoes

  class RottenMovie
    
    def self.find(options)
      raise ArgumentError, "You must search by title or id" if (options[:title].nil? && options[:id].nil?)

      results = []
      results << Rotten.api_call("movies", options)

      results.flatten!
      results.compact!

      unless (options[:limit].nil?)
        raise ArgumentError, "Limit must be an integer greater than 0" if (!options[:limit].is_a?(Fixnum) || !(options[:limit] > 0))
        results = results.slice(0, options[:limit])
      end

      results.map!{|m| RottenMovie.new(m, options[:expand_results])}

      if (results.length == 1)
        return results[0]
      else
        return results
      end		
    end

    def self.new(raw_data, expand_results = false)
      if (expand_results && !has_expanded_data?(raw_data))
        raw_data = Rotten.api_call("movies", :id => raw_data["id"])
        if !raw_data["links"].nil?
          reviews = Rotten.api_call("direct", raw_data["links"]["reviews"]) if (!raw_data["links"]["reviews"].nil?)
          cast = Rotten.api_call("direct", raw_data["links"]["cast"]) if (!raw_data["links"]["cast"].nil?)

          raw_data = raw_data.merge(reviews) if (!reviews.nil?)
          raw_data = raw_data.merge(cast) if (!cast.nil?)
        end
      end
      return Rotten.data_to_object(raw_data)
    end

    def ==(other)
      return false unless (other.is_a?(RottenMovie))
      return @raw_data == other.raw_data
    end

    private

    def self.has_expanded_data?(raw_data)
      raw_data.has_key?("mpaa_rating")
    end

  end

end
