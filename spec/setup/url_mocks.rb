def register_api_url_stubs

  unless TEST_LIVE_API
  
    File.open(File.join(File.dirname(__FILE__), "..", "fixtures", "example_com.txt")) do |file|
      stub_request(:get, Regexp.new("http://example.com")).to_return(file)
    end
    
    stub_request(:get, 'http://fakeurlisfakeforsure.com').to_return(:body => "", :status => 404, :headers => {'content-length' => 0})
    
  end

end
