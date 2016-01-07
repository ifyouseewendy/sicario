ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require File.expand_path('../../lib/models', __FILE__)
require 'rails/test_help'
require 'mocha/mini_test'

VCR.configure do |config|
  config.cassette_library_dir = "test/vcr_cassettes"
  config.hook_into :webmock # or :fakeweb
end

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  def set_auth_header
    request.headers["X-Sicario-Authorization"] = ENV['APIKEY']
  end
end

