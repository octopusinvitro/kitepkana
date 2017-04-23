require "books/result"
require "books/validator"

module Books
  class Updater
    def self.execute(book_id, attributes)
      new(book_id, attributes).execute
    end

    def initialize(book_id, attributes)
      @book_id = book_id
      @attributes = attributes
    end

    def execute
      update_book
      save_book
      result
    end

    private

    attr_reader :book_id, :attributes

    def update_book
      book.assign_attributes(attributes)
    end

    def save_book
      book.save if validation.okay?
    end

    def result
      Result.new(book, validation.messages)
    end

    def book
      @book ||= Book.find(book_id)
    end

    def validation
      @validation ||= Validator.validate(book)
    end
  end
end
