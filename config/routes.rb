Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :cargo_requests, only: [:new, :create, :show]
  root 'cargo_requests#new'
end
