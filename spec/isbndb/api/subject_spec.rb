require 'spec_helper'

RSpec.describe ISBNdb::Api::Subject do
  let(:isbndb_api_client) { ISBNdb::ApiClient.new(api_key: SecureRandom.uuid) }
  subject(:isbndb_subject) { isbndb_api_client.subject }

  describe '#initialize' do
    it 'exist' do
      expect(isbndb_subject).to_not be_nil
    end

    it 'set the client' do
      expect(isbndb_subject.client).to eq(isbndb_api_client)
    end
  end

  describe '#find' do
    context 'success' do
      it 'finds a single subject by name' do
        isbndb_mock(:subject, query_params: 'blah blah')
        subject_data = isbndb_subject.find('blah blah')
        expect(subject_data).to be_a(Hash)
      end
    end

    context 'failure' do
      it 'returns error' do
        isbndb_mock_raise_error(:subject, status: 404, query_params: 'blah error')
        expect{ isbndb_subject.find('blah error') }.to raise_error(ISBNdb::RequestError)
      end
    end
  end

  describe '#batch' do
    context 'success' do
      it 'return a list of subjects' do
        isbndb_mock(:subjects, query_params: 'blah blah')
        subjects = isbndb_subject.batch('blah blah')
        expect(subjects).to_not be_empty
        expect(subjects).to be_a(Hash)
      end
    end

    context 'failure' do
      it 'returns error' do
        isbndb_mock_raise_error(:subjects, status: 404, query_params: 'blah error')
        expect{ isbndb_subject.batch('blah error') }.to raise_error(ISBNdb::RequestError)
      end
    end
  end

  describe '#search' do
    context 'success' do
      it 'return a list of subjects' do
        isbndb_mock(:subject_search, query_params: "?subject=blah blah")
        subjects = isbndb_subject.search(subject: 'blah blah')
        expect(subjects).to_not be_empty
        expect(subjects).to be_a(Hash)
      end
    end

    context 'failure' do
      it 'returns error' do
        isbndb_mock_raise_error(:subject_search, status: 404, query_params: '?subject=blah error')
        expect{ isbndb_subject.search(subject: 'blah error') }.to raise_error(ISBNdb::RequestError)
      end
    end
  end
end
