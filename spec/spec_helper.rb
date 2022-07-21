require 'simplecov'
SimpleCov.start
require 'bundler/setup'
Bundler.setup

require 'isbndb'
require 'pry'
require 'webmock/rspec'
require_relative './helpers/webmocks'

WebMock.disable_net_connect!(allow_localhost: true)

ROOT = Pathname.new(Gem::Specification.find_by_name('isbndb-ruby').gem_dir).freeze

RSpec.configure do |config|
  config.include Helpers

  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
