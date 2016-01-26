class ModelTypesController < ApplicationController
  before_filter :find_model, only: [:index]

  rescue_from ActiveRecord::RecordNotFound do |e|
    render json: {error: "Model not Found"}, status: :not_found
  end

  def index
    render json: \
      {
        models: [
          {
            name: @model.name,
            model_types: model_types
          }
        ]
      }
  end

  private

    def find_model
      @model ||= Model.friendly.find(permitted_params[:model_id])
    end

    def model_types
      @model.model_types.map{ |mt| mt.display(:name, :total_price) }
    end

    def permitted_params
      params.permit(:model_id)
    end
end
