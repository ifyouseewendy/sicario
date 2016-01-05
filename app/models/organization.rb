class Organization < ActiveRecord::Base
  validates_inclusion_of :pricing_policy, in: %w(Flexible Fixed Prestige)
end
