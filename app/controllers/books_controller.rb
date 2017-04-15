require "book_creator"
require "book_presenter"
require "book_updater"

class BooksController < ApplicationController
  def index
    @books = Book.all.map { |book| BookPresenter.new(book) }
  end

  def new
    @book = Book.new
  end

  def create
    creation = BookCreator.execute(book_params)
    creation.successful? ? announce(creation, "created") : repeat(creation, :new)
  end

  def edit
    @book = Book.find(book_id)
  end

  def update
    update = BookUpdater.execute(book_id, book_params)
    update.successful? ? announce(update, "updated") : repeat(update, :edit)
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

  def announce(result, action)
    redirect_to root_path, notice: "Successfully #{action} book #{result.book.title}."
  end

  def repeat(result, template)
    @book = result.book
    flash.now[:alert] = result.messages
    render template
  end
end
