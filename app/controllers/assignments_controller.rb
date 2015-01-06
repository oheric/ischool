class AssignmentsController < ApplicationController
	skip_before_filter :authorize

	def show
		@assignment = Assignment.find(params[:assignment])
		@photo = Photo.new
	end

	def new_photo
		@id = params[:assignment_id]
		# now we grab a user by id so we can add a course to it
		@assignment = Assignment.find(@id)
		# Mongoid gives us the << syntax to tack on another embedded document in the 'has_many' relationship, so that is what we do here, first pulling the needed params out of the request and building a new course object with them. We then add the new course object into the has_many relationship
		@assignment.photos << Photo.new(params.require(:photo).permit(:image))
		# we then persist all of these changes to mongodb using the @user.save method call
		if @assignment.save
			# this is the tricky part. here we essentially redirect_to our show path, and we pass the @id as a parameter, so the show_path thinks it's getting called like normal with the :user being an id. So it just behaves like it normally does, grabbing a user from the db with an id that matches :user(which we have set here to have an id as a value). Since we already saved our course in the db, the show method pulls out the updated course
			redirect_to assignments_show_path(:assignment => @id)
		end
	end
end
