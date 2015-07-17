Rails.application.routes.draw do

  resources :articles
  resources :events
  resources :users
  get "signup", to: "users#new"

  root 'welcome#index'

end
