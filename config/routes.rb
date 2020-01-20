Rails.application.routes.draw do
  
  # mount Rswag::Ui::Engine => '/v1/api-docs'
  # mount Rswag::Api::Engine => '/v1/api-docs'
  
  root :to => redirect("api/v1/books")

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
