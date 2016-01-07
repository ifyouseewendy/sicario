class ModelTypesController < ApplicationController
  def index
    begin
      model_types = model.model_types.map{ |mt| mt.display(:name, :total_price) }

      render json: \
        {
          models: [
            {
              name: model.name,
              model_types: model_types
            }
          ]
        }
    rescue => e
      case e
      when ActiveRecord::RecordNotFound
        render json: {error: "Model not Found: #{params[:model_id]}"}, status: :not_found
      else
        render json: {error: 'Unknown failure', message: e.message}, status: :internal_server_error
      end
    end

  end

  private

    def model
      Model.friendly.find(permitted_params[:model_id])
    end

    def permitted_params
      params.permit(:model_id)
    end
end
