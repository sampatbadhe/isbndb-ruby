lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "isbndb/version"

Gem::Specification.new do |spec|
  spec.name          = "isbndb-ruby"
  spec.version       = ISBNdb::VERSION
  spec.authors       = ["sampatbadhe"]
  spec.email         = ["sampat.badhe@kiprosh.com"]

  spec.summary       = %q{Library for communicating with the ISBNdb.com's v2 API}
  spec.description   = %q{Library for communicating with the ISBNdb.com's v2 API}
  spec.homepage      = "https://github.com/sampatbadhe/isbndb-ruby"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "https://rubygems.org"

    spec.metadata["homepage_uri"] = spec.homepage
    spec.metadata["source_code_uri"] = "https://github.com/sampatbadhe/isbndb-ruby"
    # spec.metadata["changelog_uri"] = "TODO: Put your gem's CHANGELOG.md URL here."
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency 'httparty'
  spec.add_runtime_dependency 'plissken'
  spec.add_runtime_dependency 'addressable'

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake", '~> 12.3', '>= 12.3.3'
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency 'simplecov'
  spec.add_development_dependency 'pry', '~> 0.12'
  spec.add_development_dependency 'rubocop', '~> 0.49.0'
  spec.add_development_dependency 'webmock', '~> 2.1'
  spec.add_development_dependency 'travis', '~> 1.8'
end
