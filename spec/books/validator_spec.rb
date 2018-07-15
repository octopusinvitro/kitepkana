# frozen_string_literal: true

require 'rails_helper'
require 'books/validator'

RSpec.describe Books::Validator do
  def validation_of(book)
    Books::Validator.validate(book)
  end

  let(:invalid_book) { Book.new }

  context 'valid book' do
    let(:valid_book) { Book.new(title: 'the title', filename: 'filename.pdf') }

    it 'is valid' do
      expect(validation_of(valid_book)).to be_okay
    end

    it 'does not return any messages' do
      expect(validation_of(valid_book).messages).to be_empty
    end
  end

  context 'invalid book' do
    let(:invalid_book) { Book.new }

    it 'is not valid' do
      expect(validation_of(nil)).not_to be_okay
      expect(validation_of(invalid_book)).not_to be_okay
    end

    it 'validates existence' do
      expect(validation_of(nil).messages).to include("Book doesn't exist")
    end

    it 'validates the title' do
      expect(validation_of(invalid_book).messages).to include(
        "Title can't be empty."
      )
    end
  end
end
