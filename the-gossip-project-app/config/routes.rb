Rails.application.routes.draw do
  root "home#index"
  get "up" => "rails/health#show", as: :rails_health_check

  resources :welcome, only: [:show]
  resources :users, only: [:show, :new, :create]
  resources :teams, only: [:index]
  resources :contacts, only: [:new, :create]
  resources :gossips do
    resources :comments, only: [:create, :edit, :update, :destroy]
  end
  resources :cities, only: [:show]
end
