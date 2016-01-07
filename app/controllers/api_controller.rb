class ApiController < ApplicationController
  def heartbeat
    render json: {status: 'alive'}
  end
end
