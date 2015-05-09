Rails.application.routes.draw do

  # You can have the root of your site routed with "root"
  root 'welcome#index'

  resources :reminders
  resources :users, only: [ :index, :new, :create]

  # log in form
  get 'sessions' => 'sessions#new'
  # actually logging in the user
  post 'sessions' => 'sessions#create'
  # logging out the user
  delete 'sessions' => 'sessions#delete'
end


