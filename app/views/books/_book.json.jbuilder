json.extract! book, :id, :book_name, :category_id, :price, :isbn, :author, :publish_status, :created_at, :updated_at
json.url book_url(book, format: :json)
