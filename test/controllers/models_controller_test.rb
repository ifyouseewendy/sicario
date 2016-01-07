require 'test_helper'

class ModelsControllerTest < ActionController::TestCase
  def setup
    models(:one).save # enable slug after init from fixtures

    Organization.any_instance.stubs(:margin).returns(1000)
  end

  def test_model_types_price_route
    assert_routing(
      { method: 'post', path: '/models/one/model_types_price/330i' },
      { controller: 'models', action: 'model_types_price', id: 'one', model_type_slug: '330i' }
    )
  end

  def test_model_types_price_normal_flow
    post(:model_types_price, {id: 'one', model_type_slug: '330i', base_price: 100})
    assert_response(:success)

    data = JSON.parse(response.body)
    assert data.has_key?('model_type')
    assert_equal '330i'   , data['model_type']['name']
    assert_equal 100      , data['model_type']['base_price']
    assert_equal 100*1000 , data['model_type']['total_price']
  end

  def test_index_error_control
    post(:model_types_price, {id: 'unknown', model_type_slug: '330i', base_price: 100})
    assert_response(:missing)

    data = JSON.parse(response.body)
    assert data.has_key?('error')
  end
end
