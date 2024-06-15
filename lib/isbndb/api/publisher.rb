module ISBNdb
  module Api
    class Publisher
      attr_reader :client

      def initialize(client:)
        @client = client
      end

      def find(name, options = {})
        @client.request("/publisher/#{name}", options)
      end

      def batch(query, options = {})
        @client.request("/publishers/#{query}", options)
      end

      def search(options = {})
        @client.request("/search/publishers/", options)
      end
    end
  end
end
