module ISBNdb
  module Api
    class Author
      attr_reader :client

      def initialize(client:)
        @client = client
      end

      def find(name, options = {})
        @client.request("/author/#{name}", options)
      end

      def batch(query, options = {})
        @client.request("/authors/#{query}", options)
      end

      def search(options = {})
        @client.request("/search/authors/", options)
      end
    end
  end
end
