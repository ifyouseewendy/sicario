require 'test_helper'

class ApiControllerTest < ActionController::TestCase
  def test_auth
    get(:heartbeat)
    assert_response 401

    set_auth_header
    get(:heartbeat)
    assert_response :success
  end
end
