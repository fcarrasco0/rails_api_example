module Api::V1
  class BooksController < ApplicationController
    before_action :set_book, only: [:show, :update, :destroy]
    before_action :set_types, only: [:validate_types, :get_type_names, :books_by]
    before_action :parse_name, only: [:books_by]

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

    # orders books by sort requested /books/order/title
    def order_by

      if params[:sort] == 'description'
        msg = { 
          message: "Description is not a valid request order.",
          status: 400
        }
        render json: msg
      else
        @books = Book.order(params[:sort])

        render json:  @books, status: 200
      end
    end
    
    # return array with names of the type /genre
    def get_type_names

      if validate_type == 200
        grouped = Book.select("#{@params_type}").group(@params_type)

        render json: grouped
      end
    end
  
    # check if type requested is a valid type defined in set_types
    def validate_type
      
      if @valid_types.include?(@params_type)
        return 200
      else
        msg = {
          message: "this is not a valid type.\nvalid types are: #{@valid_types}, your type was '#{@params_type}'",
          status: 400
        }

        render json: msg
      end
    end

    # Call books_group_by if type requested ok /books_by/author/Stephen_King
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
            message: "#{type} with name:'#{name}' not found.\nplease check your writing or the word used.",
            status: :not_found
          }

          render json: msg
        end

    end
    

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_book
        @book = Book.find(params[:id])
      rescue ActiveRecord::RecordNotFound 
        render json: {
          error: "Book not found.\nPlease check the id requested."
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

      # Only allow a trusted parameter "white list" through.
      def book_params
        params.require(:book).permit(:title, :description, :author, :publisher, :release_date, :edition, :genre)
      end

  end
end