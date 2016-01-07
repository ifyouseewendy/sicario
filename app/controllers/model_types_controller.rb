class ModelTypesController < ApplicationController
  def index
    model_types = model.model_types.reduce([]) do |ary, model_type|
      ary << {
        name: model_type.name,
        total_price: model_type.total_price
      }
    end

    render json: \
      {
        models: [
          {
            name: model.name,
            model_types: model_types
          }
        ]
      }
  end

  private

    def model
      Model.friendly.find(permitted_params[:model_id])
    end

    def permitted_params
      params.permit(:model_id)
    end
end
