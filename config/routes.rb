Rails.application.routes.draw do
  
  namespace :api do
    namespace :v1 do
      resources :books

      get '/books/order/:sort', to: 'books#order_by'
      get '/:type', to: 'books#get_type_names'
      get '/books_by/:type/:name', to: 'books#books_by'
    end
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
