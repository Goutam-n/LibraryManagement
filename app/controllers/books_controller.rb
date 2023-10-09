class BooksController < ApplicationController
	before_action :authorize_request
	before_action :find_book, except: %i[create index]
	before_action :is_admin, except: %i[index show]

	def index
		@books = Book.all
		render json: @books, status: :ok
	end

	def show
		render json: @book, status: :ok
	end

	def create
		@books = Book.create(book_params)
		if @books.save
			render json: @books, status: :created
		else
			render json: {error: @books.errors.full_messages}, status: :unprocessable_entity
		end	
	end

	def update
		unless @book.update(book_params)
			render json: {error: @books.errors.full_messages}, status: :unprocessable_entity
		else
			render json: { message: "Book updated successfully"}, status: :ok
		end	
	end

	def destroy
		Book.where(title:params[:_title]).destroy_all
		render json: {message: "Book destroyed Successfully"}, status: :ok
	end

	private

	def find_book
		@book = Book.find_by_title!(params[:_title])
		rescue ActiveRecord::RecordNotFound 
			render json:{ message: "Book not found"}, status: :not_found
	end	

	def book_params
		params.permit(:title, :author, :status, :librarian_id)
	end	
end
