Rails.application.routes.draw do
  root "home#index"
  get "up" => "rails/health#show", as: :rails_health_check
  
  get "welcome/:first_name", to: "dynamic_pages#welcome"
  resources :users, only: [:show]
  resources :teams, only: [:index]
  resources :contacts, only: [:new, :create]
  resources :gossips
  resources :cities, only: [:show]
end
