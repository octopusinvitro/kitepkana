# frozen_string_literal: true

require 'rails_helper'
require 'books/updater'

RSpec.describe Books::Updater do
  let(:book) { Book.create(title: 'the title', filename: 'filename.pdf') }

  describe 'successful update' do
    let(:new_attributes) { { title: 'new title', filename: 'newfilename.pdf' } }

    it 'updates a book' do
      described_class.execute(book.id, new_attributes)
      book = Book.first
      expect(book.title).to eq(new_attributes[:title])
      expect(book.filename).to eq(new_attributes[:filename])
    end

    it 'returns a successful update' do
      update = described_class.execute(book.id, new_attributes)
      expect(update).to be_successful
    end

    it 'returns the updated book' do
      update = described_class.execute(book.id, new_attributes)
      expect(update.book).to eq(Book.first)
    end

    it 'returns no error messages' do
      update = described_class.execute(book.id, new_attributes)
      expect(update.messages).to be_empty
    end
  end

  describe 'unsuccessful update' do
    let(:new_attributes) { { title: '' } }

    it 'does not update the book' do
      described_class.execute(book.id, new_attributes)
      expect(book.reload.title).to eq('the title')
    end

    it 'returns a unsuccesful update' do
      result = described_class.execute(book.id, new_attributes)
      expect(result).not_to be_successful
    end

    it 'returns a book with no title' do
      result = described_class.execute(book.id, new_attributes)
      expect(result.book).to be_a(Book)
      expect(result.book.id).to eq(1)
      expect(result.book.title).to be_empty
    end

    it 'returns the error messages' do
      result = described_class.execute(book.id, new_attributes)
      expect(result.messages).not_to be_empty
    end
  end
end
