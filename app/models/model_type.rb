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

  def display(*fields)
    fields.reduce({}) do |ha, field|
      ha[field] = self.send(field)
      ha
    end
  end
end
