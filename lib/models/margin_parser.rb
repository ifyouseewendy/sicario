require 'nokogiri'
require 'open-uri'

class MarginParser
  attr_reader :url

  def initialize(url)
    @url = url
  end

  def parse(str, strategy:, case_sensative: false)
    raise "Invalid strategy passed" unless %i(flexible fixed prestige).include?(strategy.to_sym)

    self.send("#{strategy}_parse", str, case_sensative)
  end

  private

    def content
      @_content ||= ->{
        cont = ''
        document.traverse{|node| cont << node.text if node.text? }
        cont
      }.call
    end

    def document
      @_document ||= Nokogiri::HTML(open url)
    end

    def flexible_parse(str, case_sensative)
      reg = case_sensative ? Regexp.new(str) \
        : Regexp.new(str, Regexp::IGNORECASE)

      content.scan(reg).count
    end

    def fixed_parse(str, case_sensative)
      reg = case_sensative ? Regexp.new("\\W#{str}\\W") \
        : Regexp.new("\\W#{str}\\W", Regexp::IGNORECASE)

      content.scan(reg).count
    end

    def prestige_parse(str, case_sensative)
      raise NotImplementedError, 'No case_sensative support for prestige strategy' if case_sensative
      document.css(str).count
    end
end
