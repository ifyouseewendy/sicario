require 'test_helper'

class ModelTypeTest < ActiveSupport::TestCase
  def test_total_price
    org = organizations(:one)
    org.stubs(:total_price).returns(nil) # Mute HTTP request

    base_price = model_types(:one).base_price
    model_types(:one).stubs(:organization).returns(org)

    org.expects(:total_price).with(base_price: base_price)
    model_types(:one).total_price
  end
end
