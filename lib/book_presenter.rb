class BookPresenter
  def initialize(book)
    @book = book
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
