Rails.application.routes.draw do
  resources :uploads, only: [:index, :create, :destroy]

  resources :plays, only: [:index, :create]
end
