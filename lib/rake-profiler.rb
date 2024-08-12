require "rake-profiler/version"
require 'rake-profiler/middleware'

module RakeProfiler
  class Error < StandardError; end
  # Your code goes here...
end

if defined?(::Rails) && defined?(::Rails::VERSION) && ::Rails::VERSION::MAJOR.to_i >= 3
  require 'rake-profiler/rails/railtie'
end