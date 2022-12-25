Rails.application.routes.draw do
  root 'games#index'

  get 'wishlists/index'
  get 'wishlists/released'
  get 'wishlists/unreleased'
  post 'wishlists/delete_game'
  get 'wishlists/games/:id', to: 'games#show'

  get 'games/index'
  get 'games/wishlist'
  get 'games/add'
  post 'games/add_game'
  post 'games/delete_game'
  post 'games/search'
  get '/games/:id', to: 'games#show'

  resources :games do
    post '/search/:page', action: :search, on: :collection
  end

  resource :password_reset, only: %i[new create edit update]
  resource :session, only: %i[new create destroy]
  resources :users do
    member do
      get :confirm_email
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
