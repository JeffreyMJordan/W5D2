Rails.application.routes.draw do




  resources :users, only: [:new, :create, :destroy]
  resource :session, only: [:new, :create, :destroy]

  resources :subs, only: [:new, :create, :show] do
    resources :posts, only: [:show, :index, :create, :new]
    resources :moderators, only: [:index, :show, :create, :new]
  end


end
