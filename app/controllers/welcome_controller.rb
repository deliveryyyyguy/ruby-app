class WelcomeController < ApplicationController 
	#home page redirect if niggaa logged in
	#to the dealspage
  def home
  	redirect_to articles_path if logged_in?
  end
  def about

  end
end