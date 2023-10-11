Rails.application.routes.draw do 

  resources :users, param: :_name
  resources :books, param: :_title
  resources :borrowings, param: :book_id

  post '/auth/login', to: 'authentication#login'
  get '/*a', to: 'application#not_found'

end
