# vendors
require 'httparty'
require 'plissken'
require "addressable/uri"

# helpers w/o dependencies
require "isbndb/version"

# auth classes
require 'isbndb/api_client'

# isbndb endpoints
require 'isbndb/api/author'
require 'isbndb/api/book'
require 'isbndb/api/publisher'
require 'isbndb/api/subject'

module ISBNdb
  class RequestError < StandardError; end
end
