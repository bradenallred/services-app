Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  root 'posts#index'

  get 'analytics', to: 'home#analytics'
  get 'account', to: 'home#account'
  
  resources :posts

  resources :messages, only: [:new, :create, :index] do 
    collection do
      get ':user_id', to: 'messages#conversation', as: 'conversation'
      get ':user_id/new', to: 'messages#new', as: 'new_with_receiver'
    end
  end  
end
