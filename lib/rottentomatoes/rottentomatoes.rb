class RottenTomatoes

  require 'net/http'
  require 'uri'
  require 'cgi'
  require 'json'
  require 'deepopenstruct'

  @@api_key = ""
  @@api_response = {}

  def self.api_key
    @@api_key
  end

  def self.api_key=(key)
    @@api_key = key
  end

  def self.base_api_url
    "http://api.rottentomatoes.com/api/public/v1.0/"
  end
  
  def self.api_call(method, data)
    raise ArgumentError, "RottenTomatoes.api_key must be set before you can use the API" if(@@api_key.nil? || @@api_key.empty?)
    url = RottenTomatoes.base_api_url + method + ".json?apikey=" + @@api_key + "&q=" + CGI::escape(data.to_s)
    
    response = RottenTomatoes.get_url(url)
    return nil if(response.code.to_i != 200)
    body = JSON(response.body)
    if (body["total"] == 0)
      return nil
    else
      return body["movies"]
    end
  end

  def self.get_url(uri_str, limit = 10)
    return false if limit == 0
    begin 
      response = Net::HTTP.get_response(URI.parse(uri_str))
    rescue SocketError, Errno::ENETDOWN
      response = Net::HTTPBadRequest.new( '404', 404, "Not Found" )
      return response
    end 
    case response
      when Net::HTTPSuccess     then response
      when Net::HTTPRedirection then get_url(response['location'], limit - 1)
    else
      Net::HTTPBadRequest.new( '404', 404, "Not Found" )
    end
  end

  def self.data_to_object(data)
    object = DeepOpenStruct.load(data)
    object.raw_data = data
    return object
  end

end
