class Book < ApplicationRecord
	belongs_to :category
	enum publish_status: [:unpublished,:published]
end
