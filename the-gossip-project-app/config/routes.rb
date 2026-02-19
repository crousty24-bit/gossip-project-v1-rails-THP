Rails.application.routes.draw do
  root "home#index"
  get "up" => "rails/health#show", as: :rails_health_check

  resources :welcome, only: [:show]
  resources :users, only: [:show, :new, :create]
  resources :teams, only: [:index]
  resources :contacts, only: [:new, :create]
  resources :gossips do
    resources :likes, only: [:create, :destroy]
    resources :comments, only: [:create, :edit, :update, :destroy] do
      resources :likes, only: [:create, :destroy], controller: "comment_likes"
    end
  end
  resources :cities, only: [:show]
  resources :sessions, only: [:new, :create, :destroy]
end
