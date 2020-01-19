require 'swagger_helper'

describe "Books API" do
  path '/api/v1/books' do
    
    post "Creates a book" do
      tags 'Books'
      consumes 'application/json', 'application/xml'
      parameter name: :book, in: :body, schema: {
        type: :object,
        properties: {
          title: { type: :string },
          description: { type: :text },
          author: { type: :string  },
          publisher: { type: :string },
          genre: { type: :string },
          release_date: { type: :date },
          edition: { type: :integer } 
        },
        required: [ 'title', 'author', 'publisher', 'genre' ]
      }

      response '201', 'book created' do
        let(:book) { 
          { 
            title: "Swagger Test", 
            author: "carrasco", 
            publisher: "Hebert Richards", 
            genre: "Tech"
          } 
        }
        run_test!
      end

      response '422', 'invalid request' do
        let(:book) { 
          { 
            title: "Swagger Test"
          } 
        }
        run_test!
      end
    end

  end
end
