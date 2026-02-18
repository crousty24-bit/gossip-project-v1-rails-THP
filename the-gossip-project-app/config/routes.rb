Rails.application.routes.draw do
  root "home#index"
  get "up" => "rails/health#show", as: :rails_health_check

  get "/users/:id", to: "users#show", as:"user"
  get "welcome/:first_name", to: "dynamic_pages#welcome"
  resources :teams, only: [:index]
  resources :contacts, only: [:new, :create]
  resources :gossips
end
