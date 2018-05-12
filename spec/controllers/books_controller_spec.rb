require 'rails_helper'

RSpec.describe BooksController, type: :controller do

  before(:each) do
    @category_one = Category.create!(category_name: "Fiction")
    @category_two = Category.create!(category_name: "Non-Fiction")
    @book = Book.create!(book_name: "A day", isbn: "978-0-596-52068-7", price: 100.00, category_id: @category_one.id, author: "Author")
  end

  let(:valid_attributes) {
    {book_name: "Before", isbn: "978-0-596-52068-8", price: 50.00, category_id: @category_two.id, author: "Author"}
  }

  let(:invalid_attributes) {
    {book_name: '', isbn: "978", price: 50.00, category_id: @category_one.id, author: "Author"}
  }

  let(:valid_session) { {} }

  describe "GET #index" do
    it "returns a success response" do
      book = Book.create! valid_attributes
      get :index, params: {}
      expect(response).to be_success
    end

    it "returns a success response" do
      book = Book.create! valid_attributes
      get :index, params: {"filterrific"=>{"sorted_by"=>"book_name_desc"}}
      expect(response).to be_success
    end
  
    it "returns a success response" do
      book = Book.create! valid_attributes
      get :index, params: {"filterrific"=>{"with_book_name"=>"Before"}}
      expect(response).to be_success
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      book = Book.create! valid_attributes
      get :show, params: {id: book.to_param}
      expect(response).to be_success
    end
  end

  describe "GET #new" do
    it "returns a success response" do
      get :new, params: {"book"=>{"book_name"=>"War", "category_id"=>"2", "price"=>"34.99", "isbn"=>"978-0-596-52060-7", "author"=>"Anu"}}
      expect(response).to be_success
    end
  end

  describe "GET #edit" do
    it "returns a success response" do
      book = Book.create! valid_attributes
      get :edit, params: {id: book.to_param}
      expect(response).to be_success
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Book" do
        expect {
          post :create, params: {book: valid_attributes}
        }.to change(Book, :count).by(1)
      end

      it "redirects to the created book" do
        post :create, params: {book: valid_attributes}
        expect(response).to redirect_to(Book.last)
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'new' template)" do
        post :create, params: {book: invalid_attributes}
        expect(response).to be_success
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        {book_name: "After", price: 150.00, author: "New Author"}
      }

      it "updates the requested book" do
        book = Book.create! valid_attributes
        put :update, params: {id: book.to_param, book: new_attributes}
        book.reload
        expect(book.book_name).to eq("After")
      end

      it "redirects to the book" do
        book = Book.create! valid_attributes
        put :update, params: {id: book.to_param, book: valid_attributes}
        expect(response).to redirect_to(book)
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'edit' template)" do
        book = Book.create! valid_attributes
        put :update, params: {id: book.to_param, book: invalid_attributes}
        expect(response).to be_success
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested book" do
      book = Book.create! valid_attributes
      expect {
        delete :destroy, params: {id: book.to_param}
      }.to change(Book, :count).by(-1)
    end

    it "redirects to the books list" do
      book = Book.create! valid_attributes
      delete :destroy, params: {id: book.to_param}
      expect(response).to redirect_to(books_url)
    end
  end

  describe "PUT #change_access" do
    let(:published_attributes) {
      { publish_status: "published", book_name: "Before", isbn: "978-0-596-52068-8", price: 50.00, category_id: @category_two.id, author: "Author"}
    }
    it "returns a success response" do
      book = Book.create! valid_attributes
      put :change_access, params: {id: book.to_param}
      expect(response).to redirect_to(book)
    end
    it "publishes the requested book" do
      book = Book.create! valid_attributes
      put :change_access, params: {id: book.to_param}
      book.reload
      expect(book.publish_status).to eq("published")
    end

    it "unpublishes the published book" do
      book = Book.create! published_attributes
      put :change_access, params: {id: book.to_param}
      book.reload
      expect(book.publish_status).to eq("unpublished")
    end
  end

end
