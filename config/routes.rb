Rails.application.routes.draw do
  resources :groups
  resources :transactions
  resources :users, except: %i[new]
  root to: 'pages#home'
  get '/signup', to: 'users#new'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy' 
  get '/assigned_transactions', to: 'transactions#assigned_transactions', as: 'assigned'
  get '/unassigned_transactions', to: 'transactions#unassigned_transactions', as: 'unassigned'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  delete 'delete_user', to: 'users#destroy'

  get 'auth/:provider/callback', to: 'sessions#create' 
end
