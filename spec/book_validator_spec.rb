require "rails_helper"
require "book_validator"

RSpec.describe BookValidator do
  def validation_of(book)
    BookValidator.validate(book)
  end

  let(:invalid_book) {Book.new}

  context "valid book" do
    let(:valid_book) { Book.new(title: "the title", filename: "filename.pdf") }

    it "is valid" do
      expect(validation_of(valid_book)).to be_okay
    end

    it "does not return any messages" do
      expect(validation_of(valid_book).messages).to be_empty
    end
  end

  context "invalid book" do
    let(:invalid_book) {Book.new}

    it "is not valid" do
      expect(validation_of(invalid_book)).not_to be_okay
    end

    it "returns validation messages" do
      expect(validation_of(invalid_book).messages).not_to be_empty
    end

    it "validates the title" do
      expect(validation_of(invalid_book).messages).to include("Title can't be empty.")
    end
  end
end
