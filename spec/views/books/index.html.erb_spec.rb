require 'rails_helper'

RSpec.describe "books/index", type: :view do
  before(:each) do
    assign(:books, [
      Book.create!(
        :book_name => "Book Name",
        :category_id => 2,
        :price => "9.99",
        :isbn => "Isbn",
        :author => "Author",
        :publish_status => 3
      ),
      Book.create!(
        :book_name => "Book Name",
        :category_id => 2,
        :price => "9.99",
        :isbn => "Isbn",
        :author => "Author",
        :publish_status => 3
      )
    ])
  end

  it "renders a list of books" do
    render
    assert_select "tr>td", :text => "Book Name".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => "Isbn".to_s, :count => 2
    assert_select "tr>td", :text => "Author".to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
  end
end
