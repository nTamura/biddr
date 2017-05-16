Rails.application.routes.draw do
  root 'welcome#index'

  resources :auctions do
    resources :bids, only: [:new, :create, :destroy]
    resources :favorites, only: [:create, :destroy]
    resources :publishings, only: :create

  end

  resources :users, only: [:new, :show, :create] do
    resources :bids, only: [:index]
    resources :favorites, only: [:index, :create, :destroy]
  end

  resources :sessions, only: [:new, :create] do
    delete :destroy, on: :collection
  end

  namespace :api do
    namespace :v1 do
      resources :auctions, only: [:index, :show]
    end
  end

end
