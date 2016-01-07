require 'test_helper'

class ModelTest < ActiveSupport::TestCase
  def test_model_slug
    assert_equal nil, models(:one).slug
    models(:one).save
    assert_equal models(:one).model_slug, models(:one).slug

    assert_equal models(:one).id, Model.friendly.find('one').id
  end
end
