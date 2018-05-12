require 'rails_helper'

RSpec.describe "categories/index", type: :view do
  before(:each) do
    assign(:categories, [
      Category.create!(
        :category_name => "Category One"
      ),
      Category.create!(
        :category_name => "Category Two"
      )
    ])
  end

  it "renders a list of categories" do
    render
    assert_select "tr>td", :text => "Category One".to_s, :count => 1
  end
end
