# To generate simplecov do: COVERAGE=true rspec,
# view at: http://0.0.0.0:3000/coverage/index.html
unless ENV['DRB']
  if ENV['COVERAGE']
    require 'simplecov'

    SimpleCov.start 'rails'

    SimpleCov.configure do
      coverage_dir('public/coverage')
    end
  end
end

ENV['RAILS_ENV'] ||= 'test'

SimpleCov.start if ENV['COVERAGE']

require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'
require 'cancan/matchers'
require 'shoulda/matchers/integrations/rspec'
require 'capybara/rspec'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

RSpec.configure do |config|
  config.mock_with :rspec

  config.include CardTracker::RSpec::Matchers
  config.include FactoryGirl::Syntax::Methods

  config.include Devise::TestHelpers, :type => :controller
  config.extend ControllerSupport, :type => :controller

  config.include FeatureSupport, :type => :feature

  require 'database_cleaner'

  config.before :suite do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with :truncation
  end

  config.before :each do
    DatabaseCleaner.start
  end

  config.after :each do
    DatabaseCleaner.clean
  end

  Dir[Rails.root.join('spec/factories/**/*.rb')].each { |f| require f }

  FactoryGirl.definition_file_paths = [File.join(Rails.root, 'spec', 'factories')]
end
