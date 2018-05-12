require 'rails_helper'

RSpec.describe "books/new", type: :view do
  before(:each) do
    @category = Category.create!(category_name: "Fiction")
    assign(:book, Book.new(
      :book_name => "MyString",
      :category_id => @category.id,
      :price => "9.99",
      :isbn => "978-0-596-52068-8",
      :author => "MyString",
      :publish_status => 1
    ))
  end

  it "renders new book form" do
    render

    assert_select "form[action=?][method=?]", books_path, "post" do

      assert_select "input[name=?]", "book[book_name]"

      assert_select "input[name=?]", "book[price]"

      assert_select "input[name=?]", "book[isbn]"

      assert_select "input[name=?]", "book[author]"
    end
  end
end
