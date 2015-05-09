class UsersController < ApplicationController
	
	def index
		render json: User.all
	end

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		if @user.save
			redirect_to "/"
		else
			render :new	
		end
	end

	private
		def user_params
			params.require(:user).permit(:username, :phone_number, :password, :password_confirmation)
		end
end