require 'spec_helper'

RSpec.describe ISBNdb::Api::Author do
  let(:isbndb_api_client) { ISBNdb::ApiClient.new(api_key: SecureRandom.uuid) }
  subject(:isbndb_book) { isbndb_api_client.book }

  describe '#initialize' do
    it 'exist' do
      expect(isbndb_book).to_not be_nil
    end

    it 'set the client' do
      expect(isbndb_book.client).to eq(isbndb_api_client)
    end
  end

  describe '#find' do
    context 'success' do
      it 'finds a single book by isbn' do
        isbndb_mock(:book, query_params: '0123456789')
        book_data = isbndb_book.find('0123456789')
        expect(book_data).to be_a(Hash)
      end
    end

    context 'failure' do
      it 'returns error' do
        isbndb_mock_raise_error(:book, status: 404, query_params: 'blah')
        expect{ isbndb_book.find('blah') }.to raise_error(ISBNdb::RequestError)
      end
    end
  end

  describe '#batch' do
    context 'success' do
      it 'return a list of books' do
        isbndb_mock(:books, query_params: 'blah blah')
        books = isbndb_book.batch('blah blah')
        expect(books).to_not be_empty
        expect(books).to be_a(Hash)
      end
    end

    context 'failure' do
      it 'returns error' do
        isbndb_mock_raise_error(:books, status: 404, query_params: 'blah error')
        expect{ isbndb_book.batch('blah error') }.to raise_error(ISBNdb::RequestError)
      end
    end
  end

  describe '#search' do
    context 'success' do
      it 'return a list of books' do
        isbndb_mock(:book_search, query_params: "?text=blah blah")
        books = isbndb_book.search(text: 'blah blah')
        expect(books).to_not be_empty
        expect(books).to be_a(Hash)
      end
    end

    context 'failure' do
      it 'returns error' do
        isbndb_mock_raise_error(:book_search, status: 404, query_params: '?text=blah error')
        expect{ isbndb_book.search(text: 'blah error') }.to raise_error(ISBNdb::RequestError)
      end
    end
  end
end
