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

  def edit
    @book = Book.find(book_id)
  end

  def update
    @book = Book.find(book_id)

    if @book.update_attributes(book_params)
      redirect_to root_path, notice: "Successfully updated book #{@book.title}."
    else
      flash.now[:alert] = @book.errors.full_messages
      render :edit
    end
  end

  private

  def book_params
    params.require(:book).permit(:id, :title, :filename)
  end

  def book_id
    params[:id]
  end
end
