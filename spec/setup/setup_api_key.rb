File.open(File.join(File.dirname(__FILE__), 'rottentomatoes_api_key.txt')) do |file|
  RottenTomatoes::Rotten.api_key = file.read.chomp!
end
