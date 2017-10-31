Rails.application.routes.draw do




  get 'comments/create'

  resources :users, only: [:new, :create, :destroy]
  resource :session, only: [:new, :create, :destroy]

  resources :subs, only: [:new, :create, :show] do
    resources :posts, only: [:show, :index, :create, :new] do
      resources :comments, only: [:create]
    end
    resources :moderators, only: [:index, :show, :create, :new]
  end


end
