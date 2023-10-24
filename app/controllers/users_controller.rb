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
			
			@user = User.new(user_params)
			if @user.save
        		EmailSenderWorker.perform_async(@user.id)
				render json: @user, status: :created
			else
				render json: {error: @user.errors.full_messages}, status: :unprocessable_entity
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
			params.require(:user).permit(:name, :email, :contact_number, :password, :password_confirmation)
		end	
end
