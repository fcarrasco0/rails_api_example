require 'rails_helper'

RSpec.describe "Books", type: :request do
  describe "GET /books #index" do
    
    before do
      FactoryBot.create_list(:book, 10)
      get '/api/v1/books'
    end
    
    it "returns 200 if response equal books' array" do
      expect(response).to have_http_status(200)
    end

    it "checks if json_response is an array of book object" do
      expect(json_response[0].keys).to match_array(book_keys)
    end

  end

  describe "GET /books/1 #show" do
    
    before do
      FactoryBot.create(:book)
      get '/api/v1/books/1'
    end
    
    it "returns 200 if find book" do
      expect(response).to have_http_status(200)
    end

    it "checks if json_response is a book object" do
      expect(json_response.keys).to match_array(book_keys)  
    end
    
  end

  describe "POST /books #create" do
    
    book_params = { 
      :title => 'test',
      :author => 'author_test',
      :publisher => 'fake_publisher',
      :genre => "Fiction"
    }

    before do
      post '/api/v1/books', params: {book: book_params}
    end
    
    it "returns 201 if created book" do
      expect(response).to have_http_status(201)
    end

    it "checks if json_response is a book object" do
      expect(json_response.keys).to match_array(book_keys)
    end

    it "checks if created values equal params values" do
      expect(json_response[:title]).to match(book_params[:title])
      expect(json_response[:author]).to match(book_params[:author])
      expect(json_response[:publisher]).to match(book_params[:publisher])
      expect(json_response[:genre]).to match(book_params[:genre])
    end
  end

  describe "PUT /books/1 #update" do
    
    update_params = {:title => "Ruby On Rails"}

    before do
      FactoryBot.create(:book)
      put '/api/v1/books/1', params: {book: update_params}
    end
    
    it "returns 200 if updated book" do
      expect(response).to have_http_status(200)
    end

    it "checks if json_response is a book object" do
      expect(json_response.keys).to match_array(book_keys)
    end

    it "checks if updated values equal params values" do
      expect(json_response[:title]).to eql('Ruby On Rails')
    end
  end

  describe "DELETE /books/1 #destroy" do
    
    before do
      FactoryBot.create(:book)
      delete '/api/v1/books/1'
    end

    it "returns 200 if deleted book" do
      expect(response).to have_http_status(200)
    end

    it "checks if response has message after deleting the book" do
      expect(json_response.keys).to match_array(:message) 
    end

    it "checks if message received equals expected" do
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