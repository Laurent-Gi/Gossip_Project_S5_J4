Rails.application.routes.draw do
  
  root to: 'static#home'

  # Nested resources pour comments !
  resources :gossips do
    resources :comments
  end
  resources :users
  resources :cities
  resources :sessions, only: [:new, :create, :destroy]

  get '/team', to: 'static#team'
  get '/contact', to: 'static#contact'
  get '/welcome/:name', to: 'static#welcome'

end
