require "rails_helper"

RSpec.describe Book do
  let(:title)    {"The Title"}
  let(:filename) {"filename.pdf"}

  def create_book(attributes = {})
    Book.create!({title: title, filename: filename}.merge(attributes))
  end

  it "has a title and filename" do
    book = create_book
    expect(book.title).to eq(title)
    expect(book.filename).to eq(filename)
  end
end
