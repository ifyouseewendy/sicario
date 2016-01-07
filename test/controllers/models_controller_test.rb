require 'test_helper'

class ModelsControllerTest < ActionController::TestCase
  def setup
    models(:one).save # enable slug after init from fixtures

    ModelType.any_instance.stubs(:total_price).returns(1000)
  end

  def test_model_types_price_route
    assert_routing(
      { method: 'post', path: '/models/one/model_types_price/330i' },
      { controller: 'models', action: 'model_types_price', id: 'one', model_type_slug: '330i' }
    )
  end
end
