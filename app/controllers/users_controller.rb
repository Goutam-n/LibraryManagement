class UsersController < ApplicationController
	before_action :authorize_request, except: :create
	before_action :find_user, except: %i[create index]
    
		def index
			@users = User.all
			render json: @users, status: :ok
		end

		def show
			render json: @user, status: :ok
		end

		def create
			@users = User.create(user_params)
			if @users.save
				render json: @users, status: :created
			else
				render json: {error: @users.errors.full_messages}, status: :unprocessable_entity
			end	
		end

		def update
			unless User.update(user_params)
				render json: {error: @users.errors.full_messages}, status: :unprocessable_entity
			else
				render json: { message: "User updated successfully"}, status: :ok
			end	
		end

		def destroy
			@user.destroy
			render json: {message: "User destroyed Successfully"}, status: :ok
		end

		private

		def find_user
			@user = User.find_by_name(params[:_name])
			rescue ActiveRecord::RecordNotFound
				render json: { message: "User not found"}, status: :not_found
		end	

		def user_params
			params.permit(:name, :email, :contact_number, :password, :password_confirmation)
		end	
end
