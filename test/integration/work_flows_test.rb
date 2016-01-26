require 'test_helper'

class WorkFlowsTest < ActionDispatch::IntegrationTest
  def setup
    models(:one).save # enable slug after init from fixtures
  end

  def test_model_types
    request_without_mock do
      get '/models/one/model_types', {}, {'X-Sicario-Authorization' => ENV['APIKEY']}

      assert_response(:success)

      data = JSON.parse(response.body)
      assert_equal 1, data['models'].count
      expected_count = Model.friendly.find('one').model_types.count
      assert_equal expected_count, data['models'][0]['model_types'].count
    end
  end

  def test_model_types_price
    request_without_mock do
      post '/models/one/model_types_price/330i', { base_price: 100 }, { 'X-Sicario-Authorization' => ENV['APIKEY'] }

      assert_response(:success)

      data = JSON.parse(response.body)
      assert data.has_key?('model_type')
      assert_equal '330i'       , data['model_type']['name']
      assert_equal 100          , data['model_type']['base_price']
    end
  end

  private

    def request_without_mock
      WebMock.allow_net_connect!
      VCR.turned_off { yield }
      WebMock.disable_net_connect!
    end
end
