Rails.application.routes.draw do

  root 'posts#index'

  devise_for :users

  resources :friendships do
    member do
      post 'accept', to: 'friendships#confirm'
    end
  end
  resources :users
  resources :posts, only: [:index, :create] do
    resources :comments, only: [:create]
    resources :likes, only: [:create, :destroy]
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
