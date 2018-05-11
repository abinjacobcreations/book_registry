require 'rails_helper'

RSpec.describe "books/show", type: :view do
  before(:each) do
    @book = assign(:book, Book.create!(
      :book_name => "Book Name",
      :category_id => 2,
      :price => "9.99",
      :isbn => "Isbn",
      :author => "Author",
      :publish_status => 3
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Book Name/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(/Isbn/)
    expect(rendered).to match(/Author/)
    expect(rendered).to match(/3/)
  end
end
