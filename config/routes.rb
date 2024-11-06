Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  get 'dashboard', to: 'dashboard#index', as: 'dashboard'

      namespace :dashboard do
        resources :upload , except: [:index]
        get 'resource-management', to: 'upload#index', as: 'resource_management'
      end

    resources :messages
end
