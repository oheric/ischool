class Assignment
	include Mongoid::Document

	field :name, type: String
	field :grade, type: String

	belongs_to :student
	has_many :photos
end