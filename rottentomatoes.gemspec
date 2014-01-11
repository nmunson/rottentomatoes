# -*- encoding: utf-8 -*-
require File.expand_path("../lib/rottentomatoes/version", __FILE__)

Gem::Specification.new do |s|
  s.name        = "rottentomatoes"
  s.version     = RottenTomatoes::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Nicholas Munson"]
  s.email       = ["nmunson@gmail.com"]
  s.homepage    = "http://rubygems.org/gems/rottentomatoes"
  s.summary     = "An ActiveRecord-style API wrapper for RottenTomatoes.com"
  s.description = "An ActiveRecord-style API wrapper for RottenTomatoes.com"

  s.required_rubygems_version = ">= 1.3.6"
  s.rubyforge_project         = "rottentomatoes"

  s.add_development_dependency "bundler", ">= 1.0.0"
  s.add_development_dependency "rspec", "~> 2.14.1"
  s.add_development_dependency "webmock", ">= 1.6.2"

  s.add_dependency "deepopenstruct", ">= 0.1.2"
  s.add_dependency "json"

  s.files        = `git ls-files`.split("\n")
  s.executables  = `git ls-files`.split("\n").map{|f| f =~ /^bin\/(.*)/ ? $1 : nil}.compact
  s.require_path = 'lib'
end
