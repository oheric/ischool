class UsersController < ApplicationController
	skip_before_filter :authorize
	
	def index
	end

	def new
		@user = User.new
	end
# here User.find(params[:_id]) is what we usually use for the show method for returning the relevent user, however here we use [:user] since we changed the way we declared the parameter name in our link to show: show_path(:user => user.id)
	def show 
		@user = User.find(params[:user])
		@course = Course.new
	end

	def new_course
		# since we will use :user_id twice in our controller, we set it to a variable
		@id = params[:user_id]
		# now we grab a user by id so we can add a course to it
		@user = User.find(@id)
		# Mongoid gives us the << syntax to tack on another embedded document in the 'has_many' relationship, so that is what we do here, first pulling the needed params out of the request and building a new course object with them. We then add the new course object into the has_many relationship
		@user.courses << Course.new(params.require(:course).permit(:name, :schoolyear))
		# we then persist all of these changes to mongodb using the @user.save method call
		if @user.save
			# this is the tricky part. here we essentially redirect_to our show path, and we pass the @id as a parameter, so the show_path thinks it's getting called like normal with the :user being an id. So it just behaves like it normally does, grabbing a user from the db with an id that matches :user(which we have set here to have an id as a value). Since we already saved our course in the db, the show method pulls out the updated course
			redirect_to show_path(:user => @id)
		end
	end

	# this gives us auto login during signup
	def create 
		@user = User.new(user_params)
		if @user.save
			session[:user_id] = @user.id
			redirect_to show_path(:user => @user.id), notice: "Thank you for signing up!"
		else
			render "new"
		end
	end

# since data travels over the internet only in standardized ways, URL encoded and JSON, we need to extract the data we need from the URL encoded stuff and create a post object. this extracts only email, password, and password confirmation from the URL encoding. this params.require is a safe way to do this that rails provides
	private
	def user_params
		params.require(:user).permit(:email, :password, :password_confirmation)
	end
end

