class CoursesController < ApplicationController
	skip_before_filter :authorize

	def show
		@course = Course.find(params[:course])
		@student = Student.new

		
	end

	def new_student
		@id = params[:course_id]
		# now we grab a user by id so we can add a course to it
		@course = Course.find(@id)
		# Mongoid gives us the << syntax to tack on another embedded document in the 'has_many' relationship, so that is what we do here, first pulling the needed params out of the request and building a new course object with them. We then add the new course object into the has_many relationship
		@course.students << Student.new(params.require(:student).permit(:firstname, :lastname, :grade, :notes))
		# we then persist all of these changes to mongodb using the @user.save method call
		if @course.save
			# this is the tricky part. here we essentially redirect_to our show path, and we pass the @id as a parameter, so the show_path thinks it's getting called like normal with the :user being an id. So it just behaves like it normally does, grabbing a user from the db with an id that matches :user(which we have set here to have an id as a value). Since we already saved our course in the db, the show method pulls out the updated course
			redirect_to courses_show_path(:course => @id)
		end
	end

	def edit
		@course = Course.find(params[:course])
	end

	# def update
	# 	@id = params[:course_id]
	# 	@course = Course.find(params[:course])
	# 	if @course.update(course_params)
	# 		redirect_to show_path(:user => params[:user_id])
	# 	else 
	# 		render 'edit'
	# 	end
	# end

	# def destroy
	# 	@id = params[:course]
		
	# 	@course = Course.find(params[:course])
	# 	@course.destroy

	# 	redirect_to courses_show_path(:course => @id)
	# end


	private
	def course_params
		params.require(:course).permit(:name, :schoolyear)
	end
end
