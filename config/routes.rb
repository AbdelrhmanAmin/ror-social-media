Rails.application.routes.draw do

  root 'posts#index'

  devise_for :users

  resources :friendships do
    member do
      post 'accept', to: 'friendships#confirm'
      post 'reject', to: 'friendships#reject'
      post 'destroy', to: 'friendships#destroy'
    end
  end
  resources :users
  resources :posts do
    member do
      post 'destroy', to: 'posts#destroy'
    end
    resources :comments do
      member do
        post 'destroy', to: 'comments#destroy'
      end
    end
    resources :likes, only: [:create, :destroy]
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
