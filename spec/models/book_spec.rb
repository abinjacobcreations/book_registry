require 'rails_helper'

RSpec.describe Book, type: :model do
	describe "Book model" do
		context "Associations" do  
			it {should belong_to(:category) }
		end
	end

	describe "Book Validations" do
		it 'should validate presence' do
      record = Book.new
      record.book_name = ''
      record.isbn = ''
      record.price = ''
      record.category_id = ''
      record.author = ''

      record.valid? # run validations

      record.errors[:book_name].should include("can't be blank")
      record.errors[:isbn].should include("can't be blank")
      record.errors[:price].should include("can't be blank")
      record.errors[:category_id].should include("can't be blank")
      record.errors[:author].should include("can't be blank")
    end

    it 'should not return error for absence' do
    	record = Book.new
    	record.book_name = "New"
      record.isbn = "100"
      record.price = 67.6
      record.category_id = '1'
      record.author = 'Author'

      record.valid? # run validations

      record.errors[:book_name].should_not include("can't be blank")
      record.errors[:isbn].should_not include("can't be blank")
      record.errors[:price].should_not include("can't be blank")
      record.errors[:category_id].should_not include("can't be blank")
      record.errors[:author].should_not include("can't be blank")
    end

    it 'should validate format' do
    	record = Book.new
    	record.isbn = 'isbn'
    	record.valid?
    	record.errors[:isbn].should include("invalid Format. eg: 978-0-596-52068-7")
    end

    it 'should validate uniqueness' do
    	category = Category.create!(category_name: "Fiction")
    	old_record = Book.create!(book_name: "New", isbn: "978-0-596-52068-7", price: 50.00, category_id: category.id, author: "Author")
    	record = Book.new
    	record.isbn = "978-0-596-52068-7"
    	record.valid?
    	record.errors[:isbn].should include("has already been taken")
    end
	end
end
