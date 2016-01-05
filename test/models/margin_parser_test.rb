require 'test_helper'

class MarginParserTest < ActiveSupport::TestCase
  attr_reader :html, :content

  setup do
    @html = <<-SICARIO
      <p>
        An idealistic <a href='#'>FBI</a> agent is enlisted by a government task force to
        aid in the escalating war against drugs at the border area between the U.S. and Mexico.
      </p>
    SICARIO

    @content = <<-SICARIO
        An idealistic FBI agent is enlisted by a government task force to
        aid in the escalating war against drugs at the border area between the U.S. and Mexico.
    SICARIO

    @parser       = MarginParser.new('').tap do |pr|
      pr.instance_variable_set('@_document', Nokogiri::HTML(@html) )
    end
    @parser_one   = MarginParser.new('http://reuters.com')
    @parser_two   = MarginParser.new('https://developer.github.com/v3/#http-redirects')
    @parser_three = MarginParser.new('http://www.yourlocalguardian.co.uk/sport/rugby/rss/')
  end

  def test_strategy_flexible
    assert_equal 17,  html.scan(/a/i).count
    assert_equal 15,  content.scan(/a/i).count
    assert_equal 15,  @parser.parse('a', strategy: :flexible)
    assert_equal 14,  @parser.parse('a', strategy: :flexible, case_sensative: true)

    VCR.use_cassette("test_strategy_flexible") do
      assert_equal 477, @parser_one.parse('a', strategy: :flexible)
    end
  end

  def test_strategy_fixed
    assert_equal 3,  html.scan(/\Wa\W/i).count
    assert_equal 1,  content.scan(/\Wa\W/i).count
    assert_equal 1,  @parser.parse('an', strategy: :fixed)
    assert_equal 0,  @parser.parse('an', strategy: :fixed, case_sensative: true)

    VCR.use_cassette("test_strategy_fixed") do
      assert_equal 15, @parser_two.parse('status', strategy: :fixed)
    end
  end

  def test_strategy_prestige
    assert_equal 1,   @parser.parse('p', strategy: :prestige)

    VCR.use_cassette("test_strategy_prestige") do
      assert_equal 51, @parser_three.parse('pubdate', strategy: :prestige)
    end
  end
end

