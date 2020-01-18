Rails.application.routes.draw do
  
  namespace :api do
    namespace :v1 do
      resources :books

      get '/books/order/:order', to: 'books#order'

      get '/genres/', to: 'books#genres'
      get '/genres/:genre', to: 'books#books_by_genre'
    end
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
