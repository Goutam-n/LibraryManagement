class BorrowingsController < ApplicationController
	before_action :find_borrowing, except: %i[create index]
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
		@borrowing.destroy
		render json: {message: "Borrowing destroyed Successfully"}, status: :ok
	end

	private

	def find_borrowing
		@borrowing = Borrowing.find_by(params[:user_id])
		rescue ActiveRecord::RecordNotFound
			render json: { message: "Borrowing not found"}, status: :not_found
	end	

	def borrowing_params
		params.permit(:due_date, :return_status, :user_id, :book_id)
	end	
end
