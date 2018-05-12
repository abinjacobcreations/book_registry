class Book < ApplicationRecord
	# Associations
	belongs_to :category
	# Validations
	validates_presence_of :book_name, :author, :isbn, :price, :category_id
	validates_uniqueness_of :isbn
	validates :isbn, format: { with: /^(?:\d[\ |-]?){13}$/i, :multiline => true, message: "invalid Format. eg: 978-0-596-52068-7" }
	# Enums
	enum publish_status: [:unpublished,:published]
	# Filter conditions
	filterrific(
		default_filter_params: { sorted_by: 'created_at_desc' },
		available_filters: [
			:sorted_by,
			:with_book_name,
			:with_author,
			:with_isbn
		]
		)
	# Scopes
	scope :with_book_name, lambda { |query|
		return nil  if query.blank?
		terms = query.downcase.split(/\s+/)
		terms = terms.map { |e|
			(e.gsub('*', '%') + '%').gsub(/%+/, '%')
		}
		num_or_conds = 1
		where(
			terms.map { |term|
				"(LOWER(books.book_name) LIKE ?)"
				}.join(' AND '),
				*terms.map { |e| [e] * num_or_conds }.flatten
				)
	}

	scope :with_author, lambda { |query|
		return nil  if query.blank?
		terms = query.downcase.split(/\s+/)
		terms = terms.map { |e|
			(e.gsub('*', '%') + '%').gsub(/%+/, '%')
		}
		num_or_conds = 1
		where(
			terms.map { |term|
				"(LOWER(books.author) LIKE ?)"
				}.join(' AND '),
				*terms.map { |e| [e] * num_or_conds }.flatten
				)
	}

	scope :with_isbn, lambda { |query|
		return nil  if query.blank?
		terms = query.downcase.split(/\s+/)
		terms = terms.map { |e|
			(e.gsub('*', '%') + '%').gsub(/%+/, '%')
		}
		num_or_conds = 1
		where(
			terms.map { |term|
				"(LOWER(books.isbn) LIKE ?)"
				}.join(' AND '),
				*terms.map { |e| [e] * num_or_conds }.flatten
				)
	}

	scope :sorted_by, lambda { |sort_option|
		direction = (sort_option =~ /desc$/) ? 'desc' : 'asc'
		case sort_option.to_s
		when /^created_at_/
			order("books.created_at #{ direction }")
		when /^price_/
			order("books.price #{ direction }")
		when /^publish_status_/
			order("books.publish_status #{ direction }")
		when /^isbn_/
			order("books.isbn #{ direction }")
		when /^book_name_/
			order("LOWER(books.book_name) #{ direction }")
		when /^author_/
			order("LOWER(books.author) #{ direction }")
		when /^category_name_/
			order("LOWER(categories.category_name) #{ direction }").includes(:category).references(:category)
		else
			raise(ArgumentError, "Invalid sort option: #{ sort_option.inspect }")
		end
	}
	# Methods
	def self.options_for_sorted_by
		[
			['Name (Ascending)', 'book_name_asc'],
			['Name (Descending)', 'book_name_desc'],
			['Author (Ascending)', 'author_asc'],
			['Author (Descending)', 'author_desc'],
			['ISBN (Ascending)', 'isbn_asc'],
			['ISBN (Descending)', 'isbn_desc'],
			['Price (Low - High)', 'price_asc'],
			['Price (High - Low)', 'price_desc'],
			['Status', 'publish_status_desc'],
			['Category (a-z)', 'category_name_asc']
		]
	end
end
