require "book_validator"

class BookCreator
  def self.execute(attributes)
    new(attributes).execute
  end

  def initialize(attributes)
    @attributes = attributes
  end

  def execute
    create_book
    save_book
    result
  end

  private

  attr_reader :attributes, :book

  def create_book
    @book ||= Book.new(attributes)
  end

  def save_book
    book.save if validation.okay?
  end

  def result
    Result.new(book, validation.messages)
  end

  def validation
    @validation ||= BookValidator.validate(book)
  end

  class Result
    attr_reader :book, :messages

    def initialize(book, messages)
      @book = book
      @messages = messages
    end

    def successful?
      messages.empty?
    end
  end
end
