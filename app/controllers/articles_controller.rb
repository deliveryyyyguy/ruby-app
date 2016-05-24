class ArticlesController < ApplicationController
	
	#Before actions allow for methods to exist in more than one function
	#set_user, require_same_user, and require_admin = methods
	#[all] that are within brackets are the defined function included
  	before_action :set_article, only: [:edit, :update, :show, :destroy]
  	before_action :require_user, except: [:index, :show]
  	before_action :require_same_user, only: [:edit, :update, :destroy]

  	#Paginate the article page
	def index
		@articles = Article.paginate(page: params[:page], per_page: 5)

	end

	#Rails console commanding a new article
	def new
		@article = Article.new
	end	

	def edit

	end

	#Create an article and connect the user with the article and save
	def create
		@article = Article.new(article_params)
		@article.user = current_user
		if @article.save
			flash[:success] = "Article was placed, gj"
			redirect_to article_path(@article)
		else
			render 'new'
		end	
	end

	#Update if its within article params
	def update
		if @article.update(article_params)
			flash[:success] = "Article was updated, gj"
			redirect_to article_path(@article)
		else
			render 'edit'
		end	
	end

	def show

	end

	#Deleted with the destroy
	def destroy
		@article.destroy
		flash[:danger] = "Article deleted"
		redirect_to articles_path
	end

	private

	#All within the edit, update, show, destroy functions
	#article  with id param
	def set_article
		@article = Article.find(params[:id])
	end

	#Require title and description for the article params
	def article_params
		params.require(:article).permit(:title, :description, category_ids: [])
	end

	#if current user of the article and or admin
	#allow for edit or deletation
	def require_same_user
		if current_user != @article.user and !current_user.admin?
			flash[:danger] = "You can only edit your own articles"
			redirect_to root_path
		end
	end
end