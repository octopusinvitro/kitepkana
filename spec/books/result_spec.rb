# frozen_string_literal: true

require 'books/result'

RSpec.describe Books::Result do
  let(:book)           { double }
  let(:empty_messages) { [] }
  let(:messages)       { ['a message'] }

  it 'is successful if messages are empty' do
    result = Books::Result.new(book, empty_messages)
    expect(result).to be_successful
  end

  it 'is unsuccessful if there are messages' do
    result = Books::Result.new(book, messages)
    expect(result).not_to be_successful
  end
end
