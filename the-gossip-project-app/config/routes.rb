Rails.application.routes.draw do
  root "home#index"
  get "up" => "rails/health#show", as: :rails_health_check

  get "/users/:id", to: "users#show", as:"user"
  get "welcome/:first_name", to: "dynamic_pages#welcome"
  get '/static_pages/contact', to: 'static_pages#contact'
  get '/static_pages/team', to: 'static_pages#team'
  resources :gossips
end
