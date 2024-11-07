Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  get 'dashboard', to: 'dashboard#index', as: 'dashboard'

      namespace :dashboard do
        resources :upload , only: [:update, :create, :destroy]
        resources :faq
        get 'resource-management', to: 'upload#index', as: 'resource_management'
      end

    resources :messages
end
