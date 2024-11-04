Rails.application.routes.draw do
  devise_for :users, controllers: { 
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  get 'dashboard', to: 'dashboard#index', as: 'dashboard'

end
