Rails.application.routes.draw do

  resources :articles
  resources :events

  root 'welcome#index'

end
