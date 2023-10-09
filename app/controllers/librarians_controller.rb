class LibrariansController < ApplicationController
	before_action :authorize_request, except: :create
  before_action :find_librarian, except: %i[create index]
	
	def index
		@librarians = Librarian.all
		render json: @librarians, status: :ok
	end

	def show
		render json: @librarians, status: :ok
	end

	def create
		@librarian = Librarian.create(librarian_params)
		if @librarian.save
			render json: @librarian, status: :created
		else
			render json: {error: @librarian.errors.full_messages}, status: :unprocessable_entity
		end	
	end	

	def update
		unless @librarian.update(librarian_params)
			render json: {error: @librarian.errors.full_messages}, status: :unprocessable_entity
		else
			render json: { message: "User updated successfully"}, status: :ok
		end	
	end

	def destroy
		Librarian.where(name:params[:_name]).destroy_all
		render json: {message: "User destroyed Successfully"}, status: :ok
	end

	private

	def find_librarian
		@librarian = Librarian.find_by_name(params[:_name])
		rescue ActiveRecord::RecordNotFound
			render json: { message: "User not found"}, status: :not_found
	end	

	def librarian_params
		params.permit(:name, :email, :contact_number, :password, :password_confirmation)
	end	
end
