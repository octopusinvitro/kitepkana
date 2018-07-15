# frozen_string_literal: true

require 'rails_helper'
require 'books/destroyer'

RSpec.describe Books::Destroyer do
  let(:book) { Book.create(title: 'the title', filename: 'filename.pdf') }

  describe 'successful destroy' do
    it 'deletes the book' do
      expect(Book.all).to eq([book])
      described_class.execute(book.id)
      expect(Book.count).to eq(0)
    end

    it 'returns a successful destroy' do
      result = described_class.execute(book.id)
      expect(result).to be_successful
    end

    it 'returns the updated book' do
      result = described_class.execute(book.id)
      expect(result.book).to eq(book)
    end

    it 'returns no error messages' do
      result = described_class.execute(book.id)
      expect(result.messages).to be_empty
    end
  end

  describe 'unsuccessful destroy' do
    let(:unexisting_id) { book.id - 1 }

    it 'does not delete the book' do
      expect(Book.all).to eq([book])
      described_class.execute(unexisting_id)
      expect(Book.all).to eq([book])
    end

    it 'returns an unsuccesful destroy' do
      result = described_class.execute(unexisting_id)
      expect(result).not_to be_successful
    end

    it 'returns no book' do
      result = described_class.execute(unexisting_id)
      expect(result.book).to be_nil
    end

    it 'returns the error messages' do
      result = described_class.execute(unexisting_id)
      expect(result.messages).not_to be_empty
    end
  end
end
