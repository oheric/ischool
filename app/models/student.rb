class Student
	include Mongoid::Document

	field :firstname, type: String
	field :lastname, type: String
	field :grade, type: String
	field :notes, type: String

	belongs_to :course
	has_many :assignments
end