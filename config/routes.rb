Rails.application.routes.draw do
  root 'home#show'

  get '/auth/facebook/callback', to: 'sessions#create'
  get '/auth/failure', to: 'session#failure'
  get 'signout', to: 'sessions#destroy'

  namespace :admin do
    resources :cities
  end
end
