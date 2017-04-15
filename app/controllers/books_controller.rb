require "book_validator"
require "book_presenter"

class BooksController < ApplicationController
  def index
    @books = Book.all.to_a
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    validation = validate(@book)

    if validation.okay?
      @book.save
      redirect_to root_path, notice: "Successfully created book #{@book.title}."
    else
      flash.now[:alert] = validation.messages
      render :new
    end
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
end
