require 'sidekiq/web'

Rails.application.routes.draw do
  mount ActionCable.server, at: '/cable'
  mount Sidekiq::Web => '/sidekiq'

  resources :periods, only: [:index, :new, :create] do
    member do
      patch :toggle_status
    end

    resources :donations, only: [:index, :new, :create, :edit, :update, :destroy]
  end

  root 'home#index'
end
