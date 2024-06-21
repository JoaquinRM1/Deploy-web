Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "posts#index"
  get 'users/:id/profile', to: 'users#profile', as: 'user_profile'
  resources :posts do
    resources :comments, only: [:new, :create]
  end
  resources :comments
end
