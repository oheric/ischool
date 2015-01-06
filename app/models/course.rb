class Course 
	include Mongoid::Document
	field :name, type: String
	field :schoolyear, type: String

	belongs_to :user
	has_many :students
end