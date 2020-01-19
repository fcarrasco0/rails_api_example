require 'swagger_helper'

describe 'Books API' do

  path '/api/v1/books' do

    post 'Creates a book' do
      tags 'Books'
      parameter name: :book, in: :body, schema: {
        type: :object,
        properties: {
          title: { type: :string },
          description: { type: :string },
          author: { type: :string },
          publisher: { type: :string },
          genre: { type: :string },
          edition: { type: :number },
          release_date: { type: :string }
        },
        required: [ 'title', 'author', 'genre', 'publisher' ]
      }

      response '201', 'blog created' do
        let(:book) { { title: 'Swagger', author: 'Carrasco', genre: 'Tech', publisher: 'Rails' } }
        run_test!
      end

      response '422', 'invalid request' do
        let(:book) { { title: 'foo' } }
        run_test!
      end
    end
  end

  path '/api/v1/books/{id}' do

    get 'Retrieves a book' do
      tags 'Books'
      parameter name: :id, :in => :path
      schema type: :object,
      properties: {
        id: { type: :integer },
        title: { type: :string },
        description: { type: :string },
        author: { type: :string },
        publisher: { type: :string },
        genre: { type: :string },
        edition: { type: :number, 'x-nullable': true },
        release_date: { type: :string, 'x-nullable': true },
        created_at: { type: :timestamps },
        updated_at: { type: :timestamps }
      },
      required: [ 'id', 'title', 'author', 'genre', 'publisher' ]

      response '200', 'book found' do

        let(:id) { Book.create(title: 'Swagger', author: 'Carrasco', genre: 'Tech', publisher: 'Rails').id }
        run_test!
      end

      response '404', 'book not found' do
        let(:id) { 'invalid' }
        run_test!
      end

    end
  end
end