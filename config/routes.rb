Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  resources :posts
  resources :messages, only: [ :index, :new, :create, :show]
  
  root 'posts#index'
end
