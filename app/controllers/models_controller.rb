class ModelsController < ApplicationController
  before_filter :find_model, only: [:model_types_price]

  rescue_from ActiveRecord::RecordNotFound do |e|
    render json: {error: "Model not Found"}, status: :not_found
  end

  def model_types_price
    render json: {
      model_type: model_type.display(:name, :base_price, :total_price)
    }
  end

  private

    def find_model
      @model ||= Model.friendly.find(permitted_params[:id])
    end

    def model_type
      @model_type = @model.model_types.new(
        name: permitted_params[:model_type_slug],
        base_price: permitted_params[:base_price].to_i
      )
    end

    def permitted_params
      params.permit(:id, :model_type_slug, :base_price)
    end
end
