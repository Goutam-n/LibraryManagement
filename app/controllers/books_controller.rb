class BooksController < ApplicationController
	before_action :authorize_request, except: :search
	before_action :find_book, except: %i[create index search sort]

	def index
		@books = Book.all
		render json: @books, status: :ok
	end

	def search
  search_term = params[:search_term]

		if search_term.present?
			@books = Book.where("title LIKE ?", "%#{search_term}%")
			render json: @books, status: :ok
		else
			render json: { message: "Parameter doesn't match" }, status: :bad_request
		end
	end


	def sort
    sort_column = params[:sort_column] || 'id'
    sort_direction = params[:sort_direction] || 'asc'

    valid_columns = ['id', 'title', 'author', 'quantity']
    sort_column = valid_columns.include?(sort_column) ? sort_column : 'id'

    @books = Book.order("#{sort_column} #{sort_direction}")
    
    render json: @books, status: :ok
  end
	
	def show
		render json: @book, status: :ok
	end
	
	def create
		if isAdmin
			@book = Book.create(book_params)
			if @book.save
				render json: @book, status: :created
			else
				render json: { error: @book.errors.full_messages }, status: :unprocessable_entity
			end
		else
			render json: { message: "Unauthorized" }, status: :unauthorized
		end
	end
	
	def update
		if isAdmin
			unless @book.update(book_params)
				render json: { error: @book.errors.full_messages }, status: :unprocessable_entity
			else
				render json: { message: "Book updated successfully" }, status: :ok
			end
		else
			render json: { message: "Unauthorized" }, status: :unauthorized
		end
	end
	
	def destroy
		if isAdmin
			Book.where(title: params[:_title]).destroy_all
			render json: { message: "Book destroyed Successfully" }, status: :ok
		else
			render json: { message: "Unauthorized" }, status: :unauthorized
		end
	end
	

	private

	def find_book
		@book = Book.find_by_title!(params[:_title])
		rescue ActiveRecord::RecordNotFound 
			render json:{ message: "Book not found"}, status: :not_found
	end	

	def book_params
		params.permit(:title, :author, :quantity).merge(user_id: @current_user.id)
	end	
end
