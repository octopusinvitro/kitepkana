require "rails_helper"
require "book_presenter"

RSpec.describe BookPresenter do
  it "has an id" do
    book = Book.new
    presenter = described_class.new(book)
    expect(presenter.id).to eq(book.id)
  end

  it "titleizes the title" do
    book = Book.new(title: "the book title")
    presenter = described_class.new(book)
    expect(presenter.title).to eq("The Book Title")
  end

  it "presents the filename" do
    book = Book.new(filename: "filename.pdf")
    presenter = described_class.new(book)
    expect(presenter.filename).to eq("filename.pdf")
  end
end
