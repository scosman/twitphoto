# encoding: utf-8
require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'

require 'jeweler'
Jeweler::Tasks.new do |gem|
  gem.name = "twitphoto"
  gem.homepage = "http://github.com/scosman/twitphoto"
  gem.license = "MIT"
  gem.summary = "a gem to generate an image URL from shortened URLs from common photo sharing tools. Supports twitter/photobucket, twitpic, yfrog, instagram and twitphoto/plixi/lockerz"
  gem.description = "a gem to generate an image URL from shortened URLs from common photo sharing tools. Supports twitter/photobucket, twitpic, yfrog, instagram and tweetphoto/plixi/lockerz. It also includes support for the twitter gem, which helps with expanding t.co and bit.ly shortened URLs. Flickr is not supported as it would require a service call."
  gem.email = "delrox@live.com"
  gem.authors = ["Steve Cosman"]
  # dependencies defined in Gemfile
end
Jeweler::RubygemsDotOrgTasks.new

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/test_*.rb'
  test.verbose = true
end

require 'rcov/rcovtask'
Rcov::RcovTask.new do |test|
  test.libs << 'test'
  test.pattern = 'test/**/test_*.rb'
  test.verbose = true
  test.rcov_opts << '--exclude "gems/*"'
end

task :default => :test

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "twitphoto #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
