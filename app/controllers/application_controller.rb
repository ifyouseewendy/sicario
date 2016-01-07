class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception
  protect_from_forgery with: :null_session

  before_filter :auth

  private

    def auth
      return if request.headers['X-Sicario-Authorization'] == ENV['APIKEY']

      render json: {error: 'Invalid api key'}, status: :unauthorized
    end
end
