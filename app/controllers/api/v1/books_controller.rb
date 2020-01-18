module Api::V1
  class BooksController < ApplicationController
    before_action :set_book, only: [:show, :update, :destroy]

    # GET /books
    def index
      @books = Book.all

      render json:  @books, status: 200
    end

    # GET /books/1
    def show
      render json: @book
    end

    # POST /books
    def create
      @book = Book.new(book_params)

      if @book.save
        render json: @book, status: :created
      else
        render json: @book.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /books/1
    def update
      if @book.update(book_params)
        render json: @book
      else
        render json: @book.errors, status: :unprocessable_entity
      end
    end

    # DELETE /books/1
    def destroy
      @book.destroy
      msg = { :message => "Book destroyed with success!" }
      render json: msg
    end

    def order
      @books = Book.order(:order).all

      render json:  @books, status: 200
    end
    

    def genres
      render json: "Yes"
    end

    def books_by_genre
      @books = Book.where("genre = '#{params[:genre]}'")

      if @books.length > 0
        render json:  @books, status: 200  
      else
        render json: {
                message: "no books found probably because this genre don't exist",
                status: 401
              }
      end
      
    end

    def authors
    end
    
    def books_by_author
    end

    def publishers
    end
    
    def books_by_publisher
    end
    

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_book
        @book = Book.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def book_params
        params.require(:book).permit(:title, :description, :author, :publisher, :release_date, :edition, :genre)
      end
  end
end