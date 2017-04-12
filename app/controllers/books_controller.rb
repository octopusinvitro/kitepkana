class BooksController < ApplicationController
  def index
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)

    if @book.save
      redirect_to root_path, notice: "Successfully created book #{@book.title}."
    else
      flash.now[:alert] = @book.errors.full_messages
      render :new
    end
  end

  private

  def book_params
    params.require(:book).permit(:title, :filename)
  end
end
