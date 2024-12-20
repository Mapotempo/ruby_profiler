require_relative 'lib/ruby-profiler/version'

Gem::Specification.new do |spec|
  spec.name          = "ruby-profiler"
  spec.version       = RubyProfiler::VERSION
  spec.authors       = ["Giallombardo Nathan"]
  spec.email         = ["nagiallombardo@gmail.com"]

  spec.summary       = "rake profiler"
  spec.description   = "rake profiler"
  spec.homepage      = "https://github.com/giallon/ruby-profiler"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["allowed_push_host"] = "https://github.com/giallon/ruby-profiler"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/giallon/ruby-profiler"
  spec.metadata["changelog_uri"] = "https://github.com/giallon/ruby-profiler"

  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_runtime_dependency 'stackprof', '~> 0.2.18'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
end
