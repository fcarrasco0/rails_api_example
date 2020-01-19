# About this Project
  
  ## Introduction
    This projects aims to be an api example to learn about Rails setup and development.
    It is a book's collection RESTfull api with some other routes for filtering specific group of books and another for sort the search by a book's attribute. 
    More details up ahead.
   
  ## Dependencies

    Tool | Version Used
    ------------ | -------------
    Ruby | 2.7.0
    Ruby On Rails | 6.0.2.1

    ### gems used:

      * Used for tests:
        - gem 'rspec-rails'
        - gem "factory_bot_rails"

      * gem 'faker' (used to create seeder)

      * gem 'json' (for treating some json files)

      * gem 'rswag' (for generating some documentation file with swagger.ui)

      **OBS: this last one is not implemented right in this project yet.**


    ### Tests
      The file used for some tests is found in spec/requests/books_spec.rb and spec/integration/books_spec.rb (this last one for generating the swagger doc with rswag)

      To execute the tests use the command `bundle exec rspec spec/requests/books_spec.rb` inside the project's folder.
    

    ### Database Seeder
      db:seed

# Getting Started

```json
  {
	  "title": "Book Title",
	  "author": "Book Author",
	  "publisher": "Book Publisher",
	  "release_date": "yyyy-mm-dd",
	  "genre": "Book Genre",
	  "edition": 1
  }
```
