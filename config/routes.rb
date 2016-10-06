Rails.application.routes.draw do
  resources :periods, only: [:index, :new, :create] do
    member do
      patch :toggle_status
    end
  end

  root 'home#index'
end
