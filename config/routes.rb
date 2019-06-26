Rails.application.routes.draw do
  root to: "home#index"

  resources :uploads, only: [:index, :create, :destroy]
  resources :plays, only: [:index, :create]
end
