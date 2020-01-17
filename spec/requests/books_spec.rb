require 'rails_helper'

RSpec.describe "Books", type: :request do
  describe "GET /books #index" do
    it "returns a list of books" do

      FactoryBot.create_list(:book, 10)

      get '/api/v1/books'
      expect(response).to have_http_status(200)

      #verifying if json response has all keys
      expect(json_response[0].keys).to match_array(book_keys)
    end
  end

  describe "GET /books/1 #show" do
    it "returns a single book" do
      FactoryBot.create(:book)

      get '/api/v1/books/1'
      expect(response).to have_http_status(200)

      #verifying if json response has all keys
      expect(json_response.keys).to match_array(book_keys)

    end
  end

  describe "POST /books #create" do
    it "returns the created book" do

      book_params = { 
        :title => 'test',
        :author => 'author_test',
        :publisher => 'fake_publisher',
        :genre => "Fiction"
      }
      
      post '/api/v1/books', params: {book: book_params}
      
      expect(response).to have_http_status(201)
      expect(json_response.keys).to match_array(book_keys)
    end
  end

  describe "PUT /books/1 #update" do
    it "returns the updated book" do
      FactoryBot.create(:book)

      update_params = {:title => "Ruby On Rails"}
      
      put '/api/v1/books/1', params: {book: update_params}

      expect(response).to have_http_status(200)
      expect(json_response.keys).to match_array(book_keys)
      expect(json_response[:title]).to eql('Ruby On Rails')

    end
  end

  describe "DELETE /books/1 #destroy" do
    it "returns the message after deleting the book" do
      FactoryBot.create(:book)
      
      delete '/api/v1/books/1'

      expect(response).to have_http_status(200)

      #verifying if json response has all keys
      expect(json_response.keys).to match_array(:message) 
      expect(json_response[:message]).to eql('Book destroyed with success!')
      
    end
  end

end

# setting constants
def book_keys
  keys = [
    :id,
    :title,
    :description,
    :author,
    :publisher,
    :release_date,
    :edition, 
    :genre,
    :created_at,
    :updated_at
  ]
end

def json_response
  json_response = JSON.parse(response.body, :symbolize_names => true)
end