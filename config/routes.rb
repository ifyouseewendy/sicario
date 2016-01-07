Rails.application.routes.draw do
  resources :models, only: [] do
    resources :model_types, only: [:index]
  end
end
