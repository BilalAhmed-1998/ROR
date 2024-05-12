# frozen_string_literal: true

Rails.application.routes.draw do
  root to: redirect('/groups')
  resources :groups do
    member do
      patch 'update_user_role/:user_id/:role', to: 'groups#update_user_role', as: 'update_user_role'
      post 'add_user_to_group'
    end
  end
  post '/import_users', to: 'user_imports#import_users'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check
  # Defines the root path route ("/")
  # root "posts#index"
end
