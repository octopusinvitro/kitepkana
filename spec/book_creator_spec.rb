require "rails_helper"
require "book_creator"

RSpec.describe BookCreator do
  describe "successful creation" do
    let(:book_attributes) { {
      title:    "the title",
      filename: "filename.pdf"
    } }

    it "creates a book" do
      expect(Book.count).to eq(0)
      described_class.execute(book_attributes)
      expect(Book.count).to eq(1)
    end

    it "uses the attributes to create the book" do
      described_class.execute(book_attributes)
      book = Book.first
      expect(book.title).to eq(book_attributes[:title])
      expect(book.filename).to eq(book_attributes[:filename])
    end

    it "returns a successful creation" do
      creation = described_class.execute(book_attributes)
      expect(creation).to be_successful
    end

    it "returns the created book" do
      creation = described_class.execute(book_attributes)
      expect(creation.book).to eq(Book.first)
    end

    it "returns no error messages" do
      creation = described_class.execute(book_attributes)
      expect(creation.messages).to be_empty
    end
  end

  describe "unsuccessful creation" do
    let(:book_attributes) { { title: "" } }

    it "does not create a book" do
      described_class.execute(book_attributes)
      expect(Book.all).to be_empty
    end

    it "returns an unsuccesful creation" do
      creation = described_class.execute(book_attributes)
      expect(creation).not_to be_successful
    end

    it "returns a null book" do
      creation = described_class.execute(book_attributes)
      expect(creation.book).to be_a(Book)
      expect(creation.book.id).to be_nil
    end

    it "returns the error messages" do
      creation = described_class.execute(book_attributes)
      expect(creation.messages).not_to be_empty
    end
  end
end
