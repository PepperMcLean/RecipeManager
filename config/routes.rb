Rails.application.routes.draw do
  
  root "sessions#home"

  get '/signup' => 'users#new'
  post '/signup' => 'users#create'
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  delete '/logout' => 'sessions#delete'

  get '/auth/google_oauth2/callback' => 'sessions#googleauth'

  resources :users do
    resources :recipes, only: [:new, :create, :index]
    resources :reviews, only: [:new, :create, :index]
  end
  resources :recipes do
    resources :reviews, only: [:new, :create, :show]
  end
  resources :reviews
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
