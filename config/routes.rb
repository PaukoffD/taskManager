Rails.application.routes.draw do

  resources :tasks, only: :index

  resources :users do
    scope module: :users do
      resources :tasks
    end
  end

  resources :sessions, only: [:new, :create, :destroy]

  root 'tasks#index'

end
