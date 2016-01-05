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

  def test_margin
    %w(flexible fixed prestige).each do |strategy|
      VCR.use_cassette("test_strategy_#{strategy}") do
        # Stub parser, as #parser always inits a new MarginParser
        url         = Rails.application.secrets.margin_sites[strategy]
        stub_parser = MarginParser.new(url)
        organizations(strategy).stubs(:parser).returns(stub_parser)

        query = Rails.application.secrets.margin_queries[strategy]
        stub_parser.expects(:parse).with(query, strategy: strategy)

        organizations(strategy).margin
      end
    end
  end
end
