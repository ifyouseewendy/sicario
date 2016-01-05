class ModelType < ActiveRecord::Base
  belongs_to :model

  def organization
    model.organization
  end

  def margin
    organization.margin
  end

  def total_price
    base_price * margin
  end
end
