Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  get 'dashboard', to: 'dashboard#index', as: 'dashboard'

      namespace :dashboard do
        resources :upload , only: [:update, :create, :destroy]
        resources :faq
      end
      get 'resource-management', to: 'dashboard/upload#index', as: 'resource_management'
    resources :messages
end
