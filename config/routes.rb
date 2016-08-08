Rails.application.routes.draw do
  get 'sessions/new'

  resources :tasks, only: :index
  resources :users
  resources :sessions, only: [:new, :create, :destroy]

  root 'tasks#index'

end
