require "rails_helper"
require "book_validator"

RSpec.describe BookValidator do
  let(:valid_book)   {Book.new(title: "the title", filename: "filename.pdf")}
  let(:invalid_book) {Book.new}

  it "validates a book" do
    expect(BookValidator.valid?(valid_book)).to be_truthy
  end

  it "does not validate books with missing data" do
    expect(BookValidator.valid?(invalid_book)).to be_falsy
  end
end
