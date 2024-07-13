Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  root 'posts#index'
  
  resources :posts

  resources :messages, only: [:new, :create, :index] do 
    collection do
      get ':user_id', to: 'messages#conversation', as: 'conversation'
    end
  end  
end
