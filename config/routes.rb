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
    post 'dashboard/settings' => 'urls#create'
    put 'dashboard/settings/:id' => 'urls#update'
    patch 'dashboard/settings/:id' => 'urls#update'
    delete 'dashboard/settings/:id' => 'urls#destroy'
end
