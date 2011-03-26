module RottenTomatoes

  class RottenMovie
    
    def self.find(term, options = {})
      raise ArgumentError, "You must provide a search term" if (term.nil? || term.empty?)

      results = []
      results << Rotten.api_call("movies", term)

      results.flatten!
      results.compact!

      unless (options[:limit].nil?)
        raise ArgumentError, "Limit must be an integer greater than 0" if (!options[:limit].is_a?(Fixnum) || !(options[:limit] > 0))
        results = results.slice(0, options[:limit])
      end

      results.map!{|m| RottenMovie.new(m)}

      if (results.length == 1)
        return results[0]
      else
        return results
      end		
    end

    def self.new(raw_data)
      return Rotten.data_to_object(raw_data)
    end

    def ==(other)
      return false unless (other.is_a?(RottenMovie))
      return @raw_data == other.raw_data
    end

  end

end
