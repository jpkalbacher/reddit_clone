Rails.application.routes.draw do

  resources :posts, except: [:index, :new, :create]
  resources :subs, except: :destroy do
    resources :posts, only: [:new, :create]
  end
  resource :session, only: [:create, :new, :destroy]
  resources :users

  root 'subs#index'
end
