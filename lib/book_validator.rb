class BookValidator
  def self.valid?(book)
    new(book).valid?
  end

  def initialize(book)
    @book = book
  end

  def valid?
    has_title?
  end

  private

  attr_reader :book

  def has_title?
    book.title.present?
  end
end
