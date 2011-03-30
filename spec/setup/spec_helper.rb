require 'rubygems'

require_files = []
require_files << File.join(File.dirname(__FILE__), '..', '..', 'lib', 'rottentomatoes.rb')
require_files.concat Dir[File.join(File.dirname(__FILE__), '*.rb')]

require_files.each do |file|
  require File.expand_path(file)
end

include RottenTomatoes
