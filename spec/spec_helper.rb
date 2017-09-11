require 'emoji-regex'
require 'pry'

RSpec.configure do |config|
  config.order = 'random'
  config.example_status_persistence_file_path = '.rspec_status'
  config.disable_monkey_patching!
  config.expose_dsl_globally = true

  config.expect_with :rspec do |rspec|
    rspec.syntax = :expect
  end
end
