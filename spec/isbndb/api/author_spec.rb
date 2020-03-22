require 'spec_helper'

RSpec.describe ISBNdb::Api::Author do
  let(:isbndb_api_client) { ISBNdb::ApiClient.new(api_key: SecureRandom.uuid) }
  subject(:isbndb_author) { isbndb_api_client.author }

  describe '#initialize' do
    it 'exist' do
      expect(isbndb_author).to_not be_nil
    end

    it 'set the client' do
      expect(isbndb_author.client).to eq(isbndb_api_client)
    end
  end

  describe '#find' do
    context 'success' do
      it 'finds a single author by name' do
        isbndb_mock(:author, query_params: 'blah blah')
        author_data = isbndb_author.find('blah blah')
        expect(author_data).to be_a(Hash)
      end
    end

    context 'failure' do
      it 'returns error' do
        isbndb_mock_raise_error(:author, status: 404, query_params: 'blah error')
        expect{ isbndb_author.find('blah error') }.to raise_error(ISBNdb::RequestError)
      end
    end
  end

  describe '#batch' do
    context 'success' do
      it 'return a list of authors' do
        isbndb_mock(:authors, query_params: 'blah blah')
        authors = isbndb_author.batch('blah blah')
        expect(authors).to_not be_empty
        expect(authors).to be_a(Hash)
      end
    end

    context 'failure' do
      it 'returns error' do
        isbndb_mock_raise_error(:authors, status: 404, query_params: 'blah error')
        expect{ isbndb_author.batch('blah error') }.to raise_error(ISBNdb::RequestError)
      end
    end
  end

  describe '#search' do
    context 'success' do
      it 'return a list of authors' do
        isbndb_mock(:author_search, query_params: "?author=blah blah")
        authors = isbndb_author.search(author: 'blah blah')
        expect(authors).to_not be_empty
        expect(authors).to be_a(Hash)
      end
    end

    context 'failure' do
      it 'returns error' do
        isbndb_mock_raise_error(:author_search, status: 404, query_params: '?author=blah error')
        expect{ isbndb_author.search({author: 'blah error'}) }.to raise_error(ISBNdb::RequestError)
      end
    end
  end
end
