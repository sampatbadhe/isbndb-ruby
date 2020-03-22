module ISBNdb
  module Api
    class Publisher
      attr_reader :client

      def initialize(client:)
        @client = client
      end

      def find(name)
        @client.request("/publisher/#{name}")
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
