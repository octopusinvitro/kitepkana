module Books
  class Validator
    def self.validate(book)
      new(book).validate
    end

    def initialize(book)
      @book = book
    end

    def validate
      result = Result.new
      result << validate_existence
      result << validate_title
      result
    end

    private

    attr_reader :book

    def validate_existence
      "Book doesn't exist" unless book
    end

    def validate_title
      "Title can't be empty." if title_empty?
    end

    def title_empty?
      book.title.blank? if book
    end

    class Result
      attr_reader :messages

      def initialize
        @messages = []
      end

      def okay?
        messages.empty?
      end

      def <<(message)
        @messages << message if message
      end
    end
  end
end
