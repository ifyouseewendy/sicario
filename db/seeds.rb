Organization.destroy_all

%w(Service ShowRoom Service) \
  .zip( %w(Flexible Fixed Prestige) ) \
  .each_with_index \
  .reduce([]) do |ar, ((type, pricing_policy), idx)|
    name = "Org #{idx}"

    org = Organization.create!(
      name: name,
      public_name: name,
      type: type,
      pricing_policy: pricing_policy
    )

    name = "serie_#{idx+1}"

    model = org.models.create!(
      name: name,
      model_slug: name,
    )

    (1..2).each do |id|
      name = "bmw_#{idx*2 + id}"

      model.model_types.create!(
        name: name,
        model_type_slug: name,
        model_type_code: nil,
        base_price: 10000 * (id),
      )
    end
  end
