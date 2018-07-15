# frozen_string_literal: true

require 'books/creator'
require 'books/destroyer'
require 'books/presenter'
require 'books/updater'

class BooksController < ApplicationController
  def index
    @books = Book.all.map { |book| Books::Presenter.new(book) }
  end

  def new
    @book = Book.new
  end

  def create
    creation = Books::Creator.execute(book_params)
    if creation.successful?
      announce(creation, 'created')
    else
      repeat(creation, :new)
    end
  end

  def edit
    @book = Book.find(book_id)
  end

  def update
    update = Books::Updater.execute(book_id, book_params)
    update.successful? ? announce(update, 'updated') : repeat(update, :edit)
  end

  def show
    @book = Books::Presenter.new(Book.find(book_id))
  end

  def delete
    @book = Books::Presenter.new(Book.find(book_id))
  end

  def destroy
    destruction = Books::Destroyer.execute(book_id)
    if destruction.successful?
      announce(destruction, 'deleted')
    else
      repeat(destruction, :index)
    end
  end

  private

  def book_params
    params.require(:book).permit(:id, :title, :filename)
  end

  def book_id
    params[:id]
  end

  def announce(result, action)
    notice = "Successfully #{action} book #{result.book.title}."
    redirect_to root_path, notice: notice
  end

  def repeat(result, template)
    @book = result.book
    flash.now[:alert] = result.messages
    render template
  end
end
