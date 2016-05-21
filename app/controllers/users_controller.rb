class UsersController < ApplicationController
	#Before actions allow for methods to exist in more than one function
	#set_user, require_same_user, and require_admin = methods
	#[all] that are within brackets are the defined function included

	before_action :set_user, only: [:edit, :update, :show]
	before_action :require_same_user, only: [:edit, :update, :destroy]
	before_action :require_admin, only: [:destroy]

	#Paginate for the user page
	def index
		@users = User.paginate(page: params[:page], per_page: 5)
	end

	#New user
	def new
		@user = User.new
	end

	#Create the user and save and if successful log session using
	#User_id
	def create
		@user = User.new(user_params)
		if @user.save
			session[:user_id] = @user.id
			flash[:success] = "Welcome to the best deal site #{@user.username}"
			redirect_to user_path(@user)
		else
			render 'new'
		end
	end

	def edit

	end

	#Update user info or articles using the .update user params
	def update
		if @user.update(user_params)
			flash[:success] = "Update successful"
			redirect_to articles_path
		else
			render 'edit'
		end
	end

	#Paginate allows pages to exist. params are the page and the # per_page
	def show
		@user_articles = @user.articles.paginate(page: params[:page], per_page: 5)
	end

	#Admin can destroy the user here
	def destroy
		@user = User.find(params[:id])
		@user.destroy
		flash[:danger] = "User and all articles deleted"
		redirect_to users_path
	end

	private

	#Params for the user include username, email, password
	def user_params
		params.require(:user).permit(:username, :email, :password)
	end

	#Find the user using user_id params inside rails console
	def set_user
		@user = User.find(params[:id])
	end

	#If user is currently himself and or a user admin allow editing
	#Of his own articles
	def require_same_user
		if current_user != @user and !current_user.admin?
			flash[:danger] = "You can only edit your own account."
			redirect_to root_path
		end	
	end

	#If user is logged in, is he an admin?
	def require_admin
		if logged_in? and !current_user.admin?
			flash[:danger] = "Only admins can perform that"
			redirect_to root_path
		end
	end
end