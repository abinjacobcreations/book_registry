require 'rails_helper'

RSpec.describe "books/edit", type: :view do
  before(:each) do
    @book = assign(:book, Book.create!(
      :book_name => "MyString",
      :category_id => 1,
      :price => "9.99",
      :isbn => "MyString",
      :author => "MyString",
      :publish_status => 1
    ))
  end

  it "renders the edit book form" do
    render

    assert_select "form[action=?][method=?]", book_path(@book), "post" do

      assert_select "input[name=?]", "book[book_name]"

      assert_select "input[name=?]", "book[category_id]"

      assert_select "input[name=?]", "book[price]"

      assert_select "input[name=?]", "book[isbn]"

      assert_select "input[name=?]", "book[author]"

      assert_select "input[name=?]", "book[publish_status]"
    end
  end
end
