module RubyProfiler::RailsProfiler
  def self.initialize!(app)
    raise "RailsProfiler initialized twice. Set `require: false' for ruby-profiler in your Gemfile" if defined?(@already_initialized) && @already_initialized

    return unless Rails.env.development?

    app.middleware.insert(0, RubyProfiler::RackProfiler::Middleware)
  end

  class Railtie < ::Rails::Railtie
    initializer "ruby-profiler.configure_rails_initialization" do |app|
      ::RubyProfiler::RailsProfiler.initialize!(app)
    end
  end
end
