Rails.application.routes.draw do
  
  # Swagger
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  
  namespace :api do
    namespace :v1 do
      resources :books

      get '/books/orderBy/:sort', to: 'books#order_by'
      get 'books/groupBy/:type', to: 'books#get_type_names'
      get '/books/groupBy/:type/:name', to: 'books#books_by'
    end
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
