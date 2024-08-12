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
      save
    end

    private

    def save
      results = StackProf.results
      return if results.blank?

      filename = "profiling-#{results[:mode]}-#{Process.pid}-#{Time.now.to_i}.json"
      path = 'tmp/profiling'

      FileUtils.mkdir_p(path)
      File.open(File.join(path, filename), 'wb') do |f|
        f.write JSON.generate(results)
      end

      Rails.logger.info "#{path}/#{filename} saved"
    end
  end
end
