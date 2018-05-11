require 'rails_helper'

RSpec.describe "books/new", type: :view do
  before(:each) do
    assign(:book, Book.new(
      :book_name => "MyString",
      :category_id => 1,
      :price => "9.99",
      :isbn => "MyString",
      :author => "MyString",
      :publish_status => 1
    ))
  end

  it "renders new book form" do
    render

    assert_select "form[action=?][method=?]", books_path, "post" do

      assert_select "input[name=?]", "book[book_name]"

      assert_select "input[name=?]", "book[category_id]"

      assert_select "input[name=?]", "book[price]"

      assert_select "input[name=?]", "book[isbn]"

      assert_select "input[name=?]", "book[author]"

      assert_select "input[name=?]", "book[publish_status]"
    end
  end
end
