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
