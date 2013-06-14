# See http://rubydoc.info/gems/rspec-core/RSpec/Core/Configuration

require 'factory_girl'
require File.expand_path(File.dirname(__FILE__) + '/../lib/manage_engine/app_manager')

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = 'random'
end
