require 'test_helper'

class ModelTypeTest < ActiveSupport::TestCase
  def test_margin
    VCR.use_cassette("test_model_type_margin") do
      margin = organizations(:one).margin
      assert_equal model_types(:one).base_price*margin, model_types(:one).total_price
    end
  end
end
