class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy, :publish]

  # GET /books
  # GET /books.json
  def index
    # @books = Book.all.includes(:category)
    @filterrific = initialize_filterrific(
      Book,
      params[:filterrific],
      select_options: {
        sorted_by: Book.options_for_sorted_by
      },
      persistence_id: 'shared_key',
      default_filter_params: {},
      available_filters: [:sorted_by, :with_book_name, :with_author, :with_isbn]
    ) or return
    @books_res = @filterrific.find.page(params[:page])
    @books = @books_res.includes(:category)
    respond_to do |format|
      format.html
      format.js
    end

  end

  # GET /books/1
  # GET /books/1.json
  def show
  end

  # GET /books/new
  def new
    @book = Book.new
  end

  # GET /books/1/edit
  def edit
  end

  # POST /books
  # POST /books.json
  def create
    @book = Book.new(book_params)

    respond_to do |format|
      if @book.save
        format.html { redirect_to @book, notice: 'Book was successfully created.' }
        format.json { render :show, status: :created, location: @book }
      else
        format.html { render :new }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /books/1
  # PATCH/PUT /books/1.json
  def update
    respond_to do |format|
      if @book.update(book_params)
        format.html { redirect_to @book, notice: 'Book was successfully updated.' }
        format.json { render :show, status: :ok, location: @book }
      else
        format.html { render :edit }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /books/1
  # DELETE /books/1.json
  def destroy
    @book.destroy
    respond_to do |format|
      format.html { redirect_to books_url, notice: 'Book was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # Publish Book
  def publish
    if @book.unpublished?
      params[:book] = {}
      params[:book][:publish_status] = "published"
      respond_to do |format|
        if @book.update(publish_params)
          format.html { redirect_to @book, notice: 'Book was successfully published.' }
          format.json { render :show, status: :ok, location: @book }
        else
          format.html { render :edit }
          format.json { render json: @book.errors, status: :unprocessable_entity }
        end
      end
    else
      format.html { redirect_to books_url, notice: 'Book was already published.' }
      format.json { render json: @book.errors.add("Already Published!"), status: :unprocessable_entity }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def book_params
      params.require(:book).permit(:book_name, :category_id, :price, :isbn, :author, :publish_status)
    end

    def publish_params
      params.require(:book).permit(:publish_status)
    end
end
