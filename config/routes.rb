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

    post 'dashboard/settings/custom_prompt' => 'custom_promt#create'
    put 'dashboard/settings/custom_prompt/:id' => 'custom_promt#update'
    patch 'dashboard/settings/custom_prompt/:id' => 'custom_promt#update'
    delete 'dashboard/settings/custom_prompt/:id' => 'custom_promt#destroy'

    
    post 'dashboard/settings/chat_params' => 'chat_interaction_parameter#create'
    put 'dashboard/settings/chat_params/:id' => 'chat_interaction_parameter#update'
    patch 'dashboard/settings/chat_params/:id' => 'chat_interaction_parameter#update'
    delete 'dashboard/settings/chat_params/:id' => 'chat_interaction_parameter#destroy'
end
