require 'spec_helper'

RSpec.describe ISBNdb::ApiClient do
  let(:api_key) { 'blah' }
  subject(:isbndb_api_client) { ISBNdb::ApiClient.new(api_key: api_key) }

  describe '#initialize' do
    it 'take an api key' do
      expect(isbndb_api_client).to be_a(ISBNdb::ApiClient)
      expect(isbndb_api_client.api_key).to eq('blah')
    end

    context 'without an api key' do
      let(:api_key) { nil }
      it 'raise the error' do
        expect { isbndb_api_client }.to raise_error ArgumentError
      end
    end
  end

  describe '#request' do
    let(:parsed_response) { { blahBlog: 42 } }
    let(:code) { 200 }
    let(:response) { double(code: code, parsed_response: parsed_response) }
    let(:headers) do
      {
        'Authorization' => api_key,
        'Content-Type' => 'application/json',
        'Accept' => '*/*'
      }
    end

    it 'call HTTParty get with the correct params' do
      expect(subject.class).to receive(:get)
        .with('foo', query: { bar: 2 }, headers: headers, timeout: 60).and_return(response)
      subject.request('foo', bar: 2)
    end

    context 'when there is an error' do
      let(:code) { 234 }
      it 'raise an error if the response code is not 200' do
        expect(subject.class).to receive(:get).with('foo', anything).and_return(response)
        expect { subject.request('foo') }.to raise_error ISBNdb::RequestError
      end
    end

    context 'when there is a 400 error' do
      let(:code) { 400 }
      it 'raise an RequestError' do
        expect(subject.class).to receive(:get).with('foo', anything).and_return(response)
        expect { subject.request('foo') }.to raise_error ISBNdb::RequestError
      end
    end

    context 'when there is a 401 error' do
      let(:code) { 401 }
      it 'raise an RequestError' do
        expect(subject.class).to receive(:get).with('foo', anything).and_return(response)
        expect { subject.request('foo') }.to raise_error ISBNdb::RequestError
      end
    end

    context 'when there is a 403 error' do
      let(:code) { 403 }
      it 'raise an RequestError' do
        expect(subject.class).to receive(:get).with('foo', anything).and_return(response)
        expect { subject.request('foo') }.to raise_error ISBNdb::RequestError
      end
    end

    context 'when there is a 404 error' do
      let(:code) { 404 }
      it 'raise an RequestError' do
        expect(subject.class).to receive(:get).with('foo', anything).and_return(response)
        expect { subject.request('foo') }.to raise_error ISBNdb::RequestError
      end
    end

    context 'when there is a 422 error' do
      let(:code) { 422 }
      it 'raise an RequestError' do
        expect(subject.class).to receive(:get).with('foo', anything).and_return(response)
        expect { subject.request('foo') }.to raise_error ISBNdb::RequestError
      end
    end

    context 'when there is a 429 error' do
      let(:code) { 429 }
      it 'raise an RequestError' do
        expect(subject.class).to receive(:get).with('foo', anything).and_return(response)
        expect { subject.request('foo') }.to raise_error ISBNdb::RequestError
      end
    end

    context 'when the response is a single object' do
      it 'snake the camels' do
        expect(subject.class).to receive(:get).and_return(response)
        expect(subject.request('foo', bar: 15)).to eq(blah_blog: 42)
      end
    end

    context 'when the parsed response is incorrect json' do
      it 'returns nil' do
        expect(subject.class).to receive(:get).and_return(response)
        allow(response).to receive(:parsed_response) { raise JSON::ParserError }

        expect(subject.request('foo', bar: 15)).to be_nil
      end
    end

    context 'when the response is an array' do
      let(:parsed_response) do
        [
          { fooBar: 10 },
          { snakeFace: 22 }
        ]
      end

      it 'snake all the camels' do
        expect(subject.class).to receive(:get).and_return(response)
        expect(subject.request('foo', bar: 15)).to eq(
          [
            { foo_bar: 10 },
            { snake_face: 22 }
          ]
        )
      end
    end
  end

  describe '#author' do
    it 'return a author object' do
      expect(subject.author).to be_a(ISBNdb::Api::Author)
    end
  end

  describe '#book' do
    it 'return a book object' do
      expect(subject.book).to be_a(ISBNdb::Api::Book)
    end
  end

  describe '#publisher' do
    it 'return a publisher object' do
      expect(subject.publisher).to be_a(ISBNdb::Api::Publisher)
    end
  end

  describe '#subject' do
    it 'return a subject object' do
      expect(subject.subject).to be_a(ISBNdb::Api::Subject)
    end
  end

  describe '#stats' do
    it 'return a stats' do
      isbndb_mock(:stats)
      stats = subject.stats
      expect(stats).to be_a(Hash)
      expect(stats.keys).to include(:books, :authors, :publishers)
    end
  end
end
