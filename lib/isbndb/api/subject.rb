module ISBNdb
  module Api
    class Subject
      attr_reader :client

      def initialize(client:)
        @client = client
      end

      def find(name)
        @client.request("/subject/#{name}")
      end

      def batch(query, options = {})
        @client.request("/subjects/#{query}", options)
      end

      def search(options = {})
        @client.request("/search/subjects/", options)
      end
    end
  end
end
