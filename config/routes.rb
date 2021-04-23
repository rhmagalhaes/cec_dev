Rails.application.routes.draw do
  resources :accounts
  devise_for :users
  root 'welcome#index'
  resources :reports
  #get 'reports', to: 'reports#index'
end
