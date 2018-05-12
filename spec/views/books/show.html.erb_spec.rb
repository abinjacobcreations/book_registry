require 'rails_helper'

RSpec.describe "books/show", type: :view do
  before(:each) do
    @category = Category.create!(category_name: "Fiction")
    @book = assign(:book, Book.create!(
      :book_name => "Book Name",
      :category_id => @category.id,
      :price => "9.99",
      :isbn => "978-0-596-52068-8",
      :author => "Author",
      :publish_status => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Book Name/)
    expect(rendered).to match(/Fiction/)
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(/978-0-596-52068-8/)
    expect(rendered).to match(/Author/)
    expect(rendered).to match(/Published/)
  end
end
