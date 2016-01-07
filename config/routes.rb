Rails.application.routes.draw do
  root 'api#heartbeat'

  resources :models, only: [] do
    resources :model_types, only: [:index]

    member do
      # un-RESTful routes
      post "model_types_price/:model_type_slug", to: 'models#model_types_price'
    end
  end
end
