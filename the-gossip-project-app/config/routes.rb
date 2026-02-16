Rails.application.routes.draw do
  root "home#index"

  get "/users/:id", to: "users#show", as:"user"
  get "welcome/:first_name", to: "dynamic_pages#welcome"
  get "up" => "rails/health#show", as: :rails_health_check
  get '/static_pages/contact', to: 'static_pages#contact'
  get '/static_pages/team', to: 'static_pages#team'
  get 'gossips', to: 'gossips#index', as: :gossips
  get 'gossips/:id', to: 'gossips#show', as: :gossip
end
