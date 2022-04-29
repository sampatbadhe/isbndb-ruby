module ISBNdb
  class ApiClient
    include HTTParty
    base_uri 'https://api2.isbndb.com/'

    attr_accessor :api_key

    def initialize(api_key: nil)
      raise ArgumentError, 'API key is required.' unless api_key.is_a?(String)
      @api_key = api_key
    end

    def request(page, params = {})
      response = self.class.get(Addressable::URI.encode(page), query: params, headers: headers, timeout: 60)
      raise ISBNdb::RequestError.new "HTTP Response: #{response.code}" if response.code != 200
      begin
        self.class.snakify(response.parsed_response)
      rescue JSON::ParserError
        nil
      end
    end

    def stats
      request('/stats')
    end

    def author
      @author ||= ISBNdb::Api::Author.new(client: self)
    end

    def book
      @book ||= ISBNdb::Api::Book.new(client: self)
    end

    def publisher
      @publisher ||= ISBNdb::Api::Publisher.new(client: self)
    end

    def subject
      @subject ||= ISBNdb::Api::Subject.new(client: self)
    end

    def self.snakify(hash)
      if hash.is_a? Array
        hash.map{ |item| symbolize(item.to_snake_keys) }
      else
        symbolize(hash.to_snake_keys)
      end
    end

    private

    def headers
      {
        'Authorization' => api_key,
        'Content-Type' => 'application/json',
        'Accept' => '*/*'
      }
    end

    def self.symbolize(obj)
      return obj.reduce({}) do |memo, (k, v)|
        memo.tap { |m| m[k.to_sym] = symbolize(v) }
      end if obj.is_a? Hash
      return obj.reduce([]) do |memo, v|
        memo << symbolize(v); memo
      end if obj.is_a? Array
      obj
    end
  end
end
