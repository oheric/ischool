class Photo
	include Mongoid::Document
	include Mongoid::Paperclip

	field :date, type: DateTime

	belongs_to :assignment
	has_mongoid_attached_file :image, 
	:styles => {
		:medium => ['250x250', :jpg]
	}
	validates_attachment_content_type :image, content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"]
end