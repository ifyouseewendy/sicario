require 'test_helper'

class ModelTypesControllerTest < ActionController::TestCase
  def test_index
    assert_routing '/models/one/model_types', controller: 'model_types', action: 'index', model_id: 'one'

    get(:index, {model_id: 'one'})
    assert_response(:success)
  end
end
