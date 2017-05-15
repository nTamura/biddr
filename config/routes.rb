Rails.application.routes.draw do
  root 'welcome#index'

  resources :auctions do
    resources :bids, only: [:new, :create, :destroy]
    resources :favorites, only: [:create, :destroy]
  end

  resources :users, only: [:new, :show, :create] do
    resources :bids, only: [:index]
    resources :favorites, only: [:create, :destroy]
  end

  resources :sessions, only: [:new, :create] do
    delete :destroy, on: :collection
  end
end
