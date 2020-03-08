module ISBNdb
  module Api
    class Book
      attr_reader :client

      def initialize(client:)
        @client = client
      end

      def find(isbn)
        @client.request("/book/#{isbn}")[:book]
      end

      def batch(query, options = {})
        @client.request("/books/#{query}", options)
      end

      def search(options = {})
        @client.request("/search/books/", options)
      end
    end
  end
end
