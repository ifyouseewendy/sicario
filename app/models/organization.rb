class Organization < ActiveRecord::Base
  has_many :models

  validates_inclusion_of :pricing_policy, in: %w(Flexible Fixed Prestige)
end
