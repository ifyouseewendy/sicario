require 'test_helper'

class OrganizationTest < ActiveSupport::TestCase
  setup do
  end

  def test_on_sti
    assert_raises ActiveRecord::SubclassNotFound, 'Invalid STI types' do
      Organization.create!(type: "Hello")
    end
  end
end
