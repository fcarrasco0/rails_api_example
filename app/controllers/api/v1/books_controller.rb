module Api::V1
  class BooksController < ApplicationController
    before_action :set_book, only: [:show, :update, :destroy]
    before_action :set_types, only: [:get_type_names, :books_by]
    before_action :parse_name, only: [:books_by]

    # GET /books
    def index
      @books = Book.all

      render json:  @books, status: :ok
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
      render json: { message: "Book destroyed with success!" }, status: :ok
    end

    # orders books by sort requested /books/orderBy/title
    def order_by
      if params[:sort] == 'description'
        bad_request(1, params[:sort])
      else
        @books = Book.order(params[:sort])
        render json:  @books, status: 200
      end
    rescue
      bad_request(1, params[:sort])
    end
    
    # check if type requested is a valid type defined in set_types
    def validate_type
      if @valid_types.include?(@params_type)
        return 200
      else
        bad_request(2, @params_type)
      end
    end

    # return array with names of the type /books/groupBy/genre
    def get_type_names
      if validate_type == 200
        grouped = Book.select("#{@params_type}").group(@params_type)

        render json: grouped
      end
    end

    # Call books_group_by if type requested ok /books/groupBy/author/Stephen_King
    def books_by
      if validate_type == 200
        books_group_by(@params_type, @params_name)
      end  
    end

    # return array of books grouped by type and name requested
    def books_group_by(type, name)
      @books = Book.where("#{type} = '#{name}'")

      if @books.length > 0
        render json:  @books, status: 200  
      else
        msg = {
          message: "#{type} with name:'#{name}' not found. Please check your writing or the word used."
        }
        render json: msg, status: :not_found
      end

    end
    

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_book
        @book = Book.find(params[:id])
      rescue ActiveRecord::RecordNotFound 
        render json: {
          error: "Book not found. Please check the id requested."
        }, status: :not_found
      end

      def parse_name
        @params_name = params[:name].split(/_/)
        @params_name = @params_name.join(" ")
      end
      
      def set_types
        @valid_types = ['author', 'genre', 'publisher']
        @params_type = params[:type]
      end

      def bad_request(number, entity)
        case number
        when 1
          render json: { message: "'#{entity}' is not a valid request order." }, status: :bad_request 
        
        when 2
          msg = {
            message: "this is not a valid type. Valid types are: #{@valid_types}, your type was '#{@params_type}'"
          }

          render json: msg, status: :bad_request
        end
      end

      # Only allow a trusted parameter "white list" through.
      def book_params
        params.require(:book).permit(:title, :description, :author, :publisher, :release_date, :edition, :genre)
      end
      
  end
end