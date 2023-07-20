Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :stores
  resources :books do
    member do
      get 'assign', to: 'books#assign'
      patch 'update_assignment', to: 'books#update_assignment'
    end
  end
  # Defines the root path route ("/")
   root "books#index"
end
