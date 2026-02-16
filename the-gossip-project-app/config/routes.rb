Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check
  get '/static_pages/contact', to: 'static_pages#contact'
end
