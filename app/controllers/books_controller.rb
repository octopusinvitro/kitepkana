require "book_creator"
require "book_presenter"
require "book_validator"

class BooksController < ApplicationController
  def index
    @books = Book.all.map { |book| BookPresenter.new(book) }
  end

  def new
    @book = Book.new
  end

  def create
    creation = BookCreator.execute(book_params)
    creation.successful? ? announce(creation) : repeat(creation)
  end

  def edit
    @book = Book.find(book_id)
  end

  def update
    @book = Book.find(book_id)
    @book.assign_attributes(book_params)
    validation = validate(@book)

    if validation.okay?
      @book.save
      redirect_to root_path, notice: "Successfully updated book #{@book.title}."
    else
      flash.now[:alert] = validation.messages
      render :edit
    end
  end

  def show
    @book = BookPresenter.new(Book.find(book_id))
  end

  private

  def book_params
    params.require(:book).permit(:id, :title, :filename)
  end

  def book_id
    params[:id]
  end

  def validate(book)
    BookValidator.validate(book)
  end

  def announce(creation)
    redirect_to root_path, notice: "Successfully created book #{creation.book.title}."
  end

  def repeat(creation)
    @book = creation.book
    flash.now[:alert] = creation.messages
    render :new
  end
end
