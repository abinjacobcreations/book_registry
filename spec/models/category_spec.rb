require 'rails_helper'

RSpec.describe Category, type: :model do
	describe "Category model" do
		context "Associations" do  
			it {should have_many(:books) }
		end
	end
	
  describe "Category Validations" do
		it 'should validate presence' do
      record = Category.new
      record.category_name = ''

      record.valid? # run validations

      record.errors[:category_name].should include("can't be blank")
    end

    it 'should not return error if present' do
    	record = Category.new
      record.category_name = "Fiction"

      record.valid? # run validations

      record.errors[:category_name].should_not include("can't be blank")
    end

    it 'should validate uniqueness' do
    	category1 = Category.create!(category_name: "Fiction")
    	record = Category.new
      record.category_name = "Fiction"

    	record.valid?

    	record.errors[:category_name].should include("has already been taken")
    end
	end
end
