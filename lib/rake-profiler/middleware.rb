# frozen_string_literal: true

require 'fileutils'
require 'stackprof'

module RakeProfiler
  class Middleware
    def initialize(app, options = {})
      @app = app
      @options = options
    end

    def call(env)
      start_time = Process.clock_gettime(Process::CLOCK_MONOTONIC)
      request = ::Rack::Request.new(env)
      StackProf.start(
        mode: :wall,
        interval: 1000,
        raw: true,
        ignore_gc: true,
        metadata: {}
      )
      @app.call(env)
    ensure
      StackProf.stop
      end_time = Process.clock_gettime(Process::CLOCK_MONOTONIC)
      delta_time = ((end_time - start_time) * 1000).to_i
      save(request, delta_time)
    end

    private

    def save(request, delta_time)
      results = StackProf.results
      return if results.blank?

      route = rails_route_from_path(request.path, request.request_method)
      filename = "#{Time.now.to_i}-profiling-#{results[:mode]}-#{Process.pid}-#{route}-#{delta_time}ms.json"
      filename = sanitize_filename(filename)
      path = 'tmp/profiling'

      FileUtils.mkdir_p(path)
      File.open(File.join(path, filename), 'wb') do |f|
        f.write JSON.generate(results)
      end
    end

    def rails_route_from_path(path, method)
      hash = Rails.application.routes.recognize_path(path, method: method)
      return unless hash && hash[:controller] && hash[:action]

      Rails.logger.info hash
      "#{hash[:controller]}##{hash[:action]}"
    rescue ActionController::RoutingError
      nil
    end
  end
end
