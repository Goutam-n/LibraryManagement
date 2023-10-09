class ApplicationController < ActionController::API
  def not_found
    render json: { error: 'not_found' }
  end

  def authorize_request
    header = request.headers['Authorization']
    header = header.split(' ').last if header
    begin
      @decoded = JsonWebToken.decode(header)
      @current_user = User.find_by(email: @decoded[:email])
    rescue ActiveRecord::RecordNotFound => e
			@current_user = Librarian.find_by(email: @decoded[:email])
			@role = 'admin'

      unless @current_user	
				render json: { errors: e.message }, status: :unauthorized
			end	
    rescue JWT::DecodeError => e
      render json: { errors: e.message }, status: :unauthorized
    end
  end 
	
	def is_admin
		unless @role == 'admin'
			render json: { message: "unauthorized" }, status: :unauthorized
		end	
	end	
end


# Initially create a user and its default value will be generalUser 
# and after logged in as a user we can set it through console to admin 