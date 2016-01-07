class Organization < ActiveRecord::Base
  has_many :models, dependent: :destroy

  validates_inclusion_of :pricing_policy, in: %w(Flexible Fixed Prestige)

  def margin
    parser.parse(query, strategy: policy)
  end

  # No memoize on database field
  def policy
    pricing_policy.downcase
  end

  def total_price(base_price:)
    case policy.to_sym
    when :flexible  then base_price * margin / 100
    when :fixed     then base_price + margin
    when :prestige  then base_price + margin
    end
  end

  private

    def query
      Rails.application.secrets.margin_queries[policy]
    end

    def parser
      url = Rails.application.secrets.margin_sites[policy]
      MarginParser.new(url)
    end

end
