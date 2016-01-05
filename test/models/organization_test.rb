require 'test_helper'

class OrganizationTest < ActiveSupport::TestCase
  setup do
  end

  def test_on_sti
    assert_raises ActiveRecord::SubclassNotFound, 'Invalid STI types' do
      Organization.create!(type: "Hello", pricing_policy: 'Fixed')
    end
  end

  def test_validation_on_pricing_logic
    assert_silent do
      Organization.create!(type: "Service", pricing_policy: 'Fixed')
    end
    assert_raises ActiveRecord::RecordInvalid, 'Invalid pricing_policy' do
      Organization.create!(type: "Service", pricing_policy: 'Hello')
    end
  end
end
