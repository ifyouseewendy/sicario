require 'test_helper'

class ModelTypesControllerTest < ActionController::TestCase
  def setup
    models(:one).save # enable slug after init from fixtures

    ModelType.any_instance.stubs(:total_price).returns(1000)
  end

  def test_index
    assert_routing '/models/one/model_types', controller: 'model_types', action: 'index', model_id: 'one'

    get(:index, {model_id: 'one'})
    assert_response(:success)

    data = JSON.parse(response.body)
    assert_equal 1              , data['models'].count
    assert_equal ModelType.count, data['models'][0]['model_types'].count
    assert_equal 1000           , data['models'][0]['model_types'][0]['total_price']
  end
end
