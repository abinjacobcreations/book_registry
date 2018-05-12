require 'rails_helper'

RSpec.describe "books/index", type: :view do
  before(:each) do
    @category_one = Category.create!(category_name: "Fiction")
    @category_two = Category.create!(category_name: "Non-Fiction")
    assign(:books, [
      Book.create!(
        :book_name => "Book Name",
        :category_id => @category_one.id,
        :price => "9.99",
        :isbn => "978-0-596-52068-8",
        :author => "Author",
        :publish_status => 0
      ),
      Book.create!(
        :book_name => "Book Name",
        :category_id => @category_two.id,
        :price => "9.99",
        :isbn => "978-0-596-52068-9",
        :author => "Author",
        :publish_status => 1
      )
    ])
  end

  it "renders a list of books" do
  end
end
