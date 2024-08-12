module RakeProfiler::Rails
  def self.initialize!(app)
    raise "RakeProfilerRails initialized twice. Set `require: false' for rack-profiler in your Gemfile" if defined?(@already_initialized) && @already_initialized

    return unless Rails.env.development?

    app.middleware.insert(0, RakeProfiler::Middleware)
  end
end