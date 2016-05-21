class SessionsController < ApplicationController

	def new

	end

	#Create user session by autheticating user's email and password
	#Session by user_id stored within rails
	def create
		user = User.find_by(email: params[:session][:email].downcase)
		if user && user.authenticate(params[:session][:password])
			session[:user_id] = user.id
			flash[:success] = "You have successfully logged in"
			redirect_to user_path(user)
		else
			flash.now[:danger] = "Invalid Information"
			render 'new'
		end
	end

	#Log out by destroying the session
	def destroy
		session[:user_id] = nil
		flash[:success] = "You have logged out."
		redirect_to root_path
	end

end