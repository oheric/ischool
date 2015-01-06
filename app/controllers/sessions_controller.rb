class SessionsController < ApplicationController
  skip_before_filter :authorize
  
  def new
  end

  def create
  	user = User.where(email: params[:email]).first
  	# first make sure we actually find a user then see if user authenticates
  	if user && user.authenticate(params[:password])
  		# sets the cookie to the browser
  		session[:user_id] = user.id
  		redirect_to show_path(:user => user.id)
  	else
  		flash.now.alert = "Email or password is invalid"
  		render "new"
  	end
  end

  def destroy
  	# kills cookies
  	reset_session
  	redirect_to root_path
  end
end
