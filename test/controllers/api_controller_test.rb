require 'test_helper'

class ApiControllerTest < ActionController::TestCase
  def test_auth
    get(:heartbeat)
    assert_response 401

    request.headers["X-Sicario-Authorization"] = ENV['APIKEY']
    get(:heartbeat)
    assert_response :success
  end
end
