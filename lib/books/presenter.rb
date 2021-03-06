# frozen_string_literal: true

module Books
  class Presenter
    def initialize(book)
      @book = book
    end

    def instance
      book
    end

    def id
      book.id
    end

    def title
      book.title.titleize
    end

    def filename
      book.filename
    end

    private

    attr_reader :book
  end
end
