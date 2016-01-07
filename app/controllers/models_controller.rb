class ModelsController < ApplicationController
  def model_types_price
    begin
      model_type = model.model_types.new(
        name: permitted_params[:model_type_slug],
        base_price: permitted_params[:base_price].to_i
      )

      render json: \
        {
          model_type: {
            name: model_type.name,
            base_price: model_type.base_price,
            total_price: model_type.total_price
          }
        }
    rescue => e
      case e
      when ActiveRecord::RecordNotFound
        render json: {error: "Model not Found: #{params[:id]}"}, status: :not_found
      else
        render json: {error: 'Unknown failure', message: e.message}, status: :internal_server_error
      end
    end
  end

  private

    def model
      Model.friendly.find(permitted_params[:id])
    end

    def permitted_params
      params.permit(:id, :model_type_slug, :base_price)
    end
end
