class WelcomeController < ApplicationController 
	
	#Home page and will redirect you to deals/articles page
	#If you are already logged in
  	def home
  		redirect_to articles_path if logged_in?
  	end

  	def about

  	end
end