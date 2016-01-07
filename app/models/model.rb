class Model < ActiveRecord::Base
  belongs_to :organization
  has_many :model_types, dependent: :destroy

  extend FriendlyId
  friendly_id :model_slug, use: :slugged
end
