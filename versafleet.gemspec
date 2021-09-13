# frozen_string_literal: true

require_relative "lib/versafleet/version"

Gem::Specification.new do |spec|
  spec.name = "versafleet"
  spec.version = Versafleet::VERSION
  spec.authors = ["Maful Prayoga A"]
  spec.email = ["mafulprayoga@gmail.com"]

  spec.summary = "Ruby bindings for the VersaFleet API"
  spec.homepage = "https://versafleet.co"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.4.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["bug_tracker_uri"] = "https://github.com/maful/versafleet-ruby/issues"
  spec.metadata["source_code_uri"] = "https://github.com/maful/versafleet-ruby"
  spec.metadata["github_repo"] = "https://github.com/maful/versafleet-ruby"
  # spec.metadata["changelog_uri"] = "https://github.com/maful/versafleet-ruby/blob/main/CHANGELOG.md"
  # spec.metadata["documentation_uri"] = "TODO: Add documentation"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "faraday", "~> 1.7"
  spec.add_dependency "faraday_middleware", "~> 1.1"
end
