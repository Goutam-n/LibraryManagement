Rails.application.routes.draw do 
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

  resources :users, param: :_name

  resources :books, param: :_title do
    collection do
      get 'search'
      get 'sort'
    end
  end

  resources :borrowings, param: :book_id

  post '/auth/login', to: 'authentication#login'
  get '/*a', to: 'application#not_found'

end
