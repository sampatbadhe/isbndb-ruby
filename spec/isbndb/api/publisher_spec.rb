require 'spec_helper'

RSpec.describe ISBNdb::Api::Publisher do
  let(:isbndb_api_client) { ISBNdb::ApiClient.new(api_key: SecureRandom.uuid) }
  subject(:isbndb_publisher) { isbndb_api_client.publisher }

  describe '#initialize' do
    it 'exist' do
      expect(isbndb_publisher).to_not be_nil
    end

    it 'set the client' do
      expect(isbndb_publisher.client).to eq(isbndb_api_client)
    end
  end

  describe '#find' do
    context 'success' do
      it 'finds a single publisher by name' do
        isbndb_mock(:publisher, query_params: 'blah blah')
        publisher_data = isbndb_publisher.find('blah blah')
        expect(publisher_data).to be_a(Hash)
      end
    end

    context 'failure' do
      it 'returns error' do
        isbndb_mock_raise_error(:publisher, status: 404, query_params: 'blah error')
        expect{ isbndb_publisher.find('blah error') }.to raise_error(ISBNdb::RequestError)
      end
    end
  end

  describe '#batch' do
    context 'success' do
      it 'return a list of publishers' do
        isbndb_mock(:publishers, query_params: 'blah blah')
        publishers = isbndb_publisher.batch('blah blah')
        expect(publishers).to_not be_empty
        expect(publishers).to be_a(Hash)
      end
    end

    context 'failure' do
      it 'returns error' do
        isbndb_mock_raise_error(:publishers, status: 404, query_params: 'blah error')
        expect{ isbndb_publisher.batch('blah error') }.to raise_error(ISBNdb::RequestError)
      end
    end
  end

  describe '#search' do
    context 'success' do
      it 'return a list of publishers' do
        isbndb_mock(:publisher_search, query_params: "?publisher=blah blah")
        publishers = isbndb_publisher.search({publisher: 'blah blah'})
        expect(publishers).to_not be_empty
        expect(publishers).to be_a(Hash)
    end

    context 'failure' do
      it 'returns error' do
        isbndb_mock_raise_error(:publisher_search, status: 404, query_params: '?publisher=blah error')
        expect{ isbndb_publisher.search(publisher: 'blah error') }.to raise_error(ISBNdb::RequestError)
      end
    end
  end
  end
end
