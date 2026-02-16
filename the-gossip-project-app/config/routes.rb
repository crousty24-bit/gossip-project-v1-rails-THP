Rails.application.routes.draw do
  
  root "home#index"

  get "dynamic_pages/welcome"
  get "up" => "rails/health#show", as: :rails_health_check
  get '/static_pages/contact', to: 'static_pages#contact'
  get '/static_pages/team', to: 'static_pages#team'
end
