Rails.application.routes.draw do
  root 'games#index'
  get 'games/index'
  get 'games/wishlist'
  get 'sessions/new'
  get 'sessions/create'
  get 'sessions/destroy'
  resource :password_reset, only: %i[new create edit update ]
  #resources :users, only: %i[new create edit update]
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
