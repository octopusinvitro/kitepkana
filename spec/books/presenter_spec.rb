# frozen_string_literal: true

require 'rails_helper'
require 'books/presenter'

RSpec.describe Books::Presenter do
  it 'has an instance of the book it decorates' do
    book = Book.new
    presenter = described_class.new(book)
    expect(presenter.instance).to eq(book)
  end

  it 'has an id' do
    book = Book.new
    presenter = described_class.new(book)
    expect(presenter.id).to eq(book.id)
  end

  it 'titleizes the title' do
    book = Book.new(title: 'the book title')
    presenter = described_class.new(book)
    expect(presenter.title).to eq('The Book Title')
  end

  it 'presents the filename' do
    book = Book.new(filename: 'filename.pdf')
    presenter = described_class.new(book)
    expect(presenter.filename).to eq('filename.pdf')
  end
end
