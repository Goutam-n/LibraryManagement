class BorrowingsController < ApplicationController
	before_action :find_borrowing, except: %i[create index]
	before_action :find_availability, only: %i[create]
	
	def index
		@borrowing = Borrowing.all
		render json: @borrowing, status: :ok
	end

	def show
		render json: @borrowing, status: :ok
	end

	def create
		@borrowing = Borrowing.create(borrowing_params)
		if @borrowing.save
			render json: @borrowing, status: :created
		else
			render json: {error: @borrowing.errors.full_messages}, status: :unprocessable_entity
		end	
	end

	def update
		unless @borrowing.update(borrowing_params)
			render json: {error: @borrowing.errors.full_messages}, status: :unprocessable_entity
		else
			render json: { message: "borrowing updated successfully"}, status: :ok
		end	
	end

	def destroy
		@books = Book.find_by(id: params[:book_id])
		if @books
			@borrowings.each do |borrowing|
				borrowing.destroy
				@books.update(quantity: @books.quantity + 1)
			
			render json: { message: "Borrowing destroyed Successfully" }, status: :ok	
		else
			rescue ActiveRecord::RecordNotFound
				render json: { message: "Record not found" }, status: :not_found
		end
	end
	
	private
	
	def find_availability
		@book = Book.find_by(id: params[:book_id])
		if @book && @book.quantity > 0
			@book.update(quantity: @book.quantity - 1)
		else
			render json: { message: "Book is not available" }, status: :not_found
		end
	rescue ActiveRecord::RecordNotFound
		render json: { message: "Book not found" }, status: :not_found
	end
	
	def find_borrowing
		@borrowings = Borrowing.where(book_id: params[:book_id], user_id: current_user.id)
		rescue ActiveRecord::RecordNotFound
			render json: { message: "Borrowing not found"}, status: :not_found
	end	

	def borrowing_params
		params.permit(:due_date, :book_id).merge(user_id: current_user.id)
	end		  
	
end
