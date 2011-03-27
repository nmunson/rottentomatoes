module RottenTomatoes

  class RottenList

    def self.find(options)
      raise ArgumentError, ":type must be set" if (options[:type].nil?)
      if !["box_office", "in_theaters", "opening", "upcoming", "new_releases"].include?(options[:type])
        raise ArgumentError, ":type must be a recognized format"
      end

      results = []
      results << Rotten.api_call("lists", options)

      return Rotten.process_results(results, options)
    end

  end

end
