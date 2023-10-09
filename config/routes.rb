Rails.application.routes.draw do
  devise_for :users 
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :users, param: :_name
  resources :books, param: :_title
  resources :librarians, param: :_name
  resources :borrowings, param: :user_id


  post '/auth/login', to: 'authentication#login'
  get '/*a', to: 'application#not_found'

  # delete '/borrowings/destroy'=> 'borrowings#destroy'
  # get '/borrowings/show'=> 'borrowings#show'
end
