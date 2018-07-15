# frozen_string_literal: true

require 'books/result'
require 'books/validator'

module Books
  class Destroyer
    def self.execute(book_id)
      new(book_id).execute
    end

    def initialize(book_id)
      @book_id = book_id.to_s
    end

    def execute
      destroy_book
      result
    end

    private

    attr_reader :book_id

    def destroy_book
      book.destroy if validation.okay?
    end

    def result
      Result.new(book, validation.messages)
    end

    def book
      @book ||= Book.find_by(book_id)
    end

    def validation
      @validation ||= Validator.validate(book)
    end
  end
end
