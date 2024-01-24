Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
  }

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  resources :cargo_requests, only: [:new, :create, :show, :index] do
    member do
      put :approve
      put :reject
      put :reset_to_pending
    end
  end

  root 'cargo_requests#new'
end
