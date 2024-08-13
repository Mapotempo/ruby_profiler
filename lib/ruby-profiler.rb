require "ruby-profiler/version"
require 'ruby-profiler/rack-profiler/middleware'

module RubyProfiler
  class Error < StandardError; end
  # Your code goes here...
end

if defined?(::Rails) && defined?(::Rails::VERSION) && ::Rails::VERSION::MAJOR.to_i >= 3
  require 'ruby-profiler/rails-profiler/railtie'
end