# Ruby library for ISBNdb API v2

[![Build Status](https://semaphoreci.com/api/v1/sampat-badhe/isbndb-ruby/branches/master/badge.svg)](https://semaphoreci.com/sampat-badhe/isbndb-ruby)

* [Homepage](https://isbndb.com/)
* [API Documentation](https://isbndb.com/apidocs/v2)
* [Register](https://isbndb.com/isbn-database)

## Description

Provides a Ruby interface to [ISBNdb](https://isbndb.com/). This library is designed to help ruby applications consume the ISBNdb API v2.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'isbndb-ruby'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install isbndb-ruby

## Usage

### Setup

Register for your API KEY at https://isbndb.com/isbn-database

**Initialize**
```ruby
  require 'isbndb-ruby'

  isbndb_api_client = ISBNdb::ApiClient.new(api_key: api_key)
```

**Account Stats**
```ruby
  #=> Returns a status object about the ISBNDB database.
  isbndb_api_client.stats
```

**Author**

- Get single author details

```ruby
  #=> Returns the author name and a list of books by the author.
  isbndb_api_client.author.find(name, options)
    name = `The name of an author in the Author's database`
    options = {
      page: 1,
      pageSize: 20
    }
```

- Authors List

```ruby
  #=> This returns a list of authors who's name matches the given query.
  isbndb_api_client.author.batch(query, options)
    query = `A string to search for in the Author’s database`
    options = {
      page: 1, # for books
      pageSize: 20 # for books
    }
```

- Authors Search

```ruby
  #=> This returns a list of authors who's name matches the given query.
  isbndb_api_client.author.search(options)
    options = {
      page: 1,
      pageSize: 20,
      author: `The name of an author in the Author's database`,
      text: `A string to search for determinate author database`
    }
```

**Book**

- Get single book details

```ruby
  #=> Returns the book details
  isbndb_api_client.book.find(isbn)
    isbn = `an ISBN 10 or ISBN 13 in the Books database`
```

- Books List

```ruby
  #=> This returns a list of books that match the query
  isbndb_api_client.book.batch(query, options)
    query = `A string to search for in the Book’s database`
    options = {
      page: 1,
      pageSize: 20,
      column: specify the column to search
              - '' - Empty value search in every column
              - title - Only searches in Books Title
              - author - Only searches books by the given Author
              - Available values : , title, author,
      beta: A integer (1 or 0) for enable or disable beta searching.
            Default value : 0 (disabled)
```

- Books Search

```ruby
  #=> This returns a list of authors who's name matches the given query.
  isbndb_api_client.author.search(options)
    options = {
      page: 1,
      pageSize: 20,
      isbn: `an ISBN 10 in the Books database`,
      isbn13: `an ISBN 13 in the Books database`,
      text: `A string to search for determinate author database`
    }
```

**Publisher**

- Get single publisher details

```ruby
  #=> Returns the publisher name and a list of books by the publisher.
  isbndb_api_client.publisher.find(name, options)
    name =  `The name of a publisher in the Publisher's database`
    options = {
      page: 1,
      pageSize: 20
    }
```

- Publishers List

```ruby
  #=> This returns a list of publishers who's name matches the given query.
  isbndb_api_client.publisher.batch(query, options)
    query = `A string to search for in the Publisher’s database`
    options = {
      page: 1, # for books
      pageSize: 20 # for books
    }
```

- Publishers Search

```ruby
  #=> This returns a list of publishers who's name matches the given query.
  isbndb_api_client.publisher.search(options)
    options = {
      page: 1,
      pageSize: 20,
      publisher: `The name of an publisher in the publisher's database`,
      text: `A string to search for determinate publisher database`
    }
```

**Subject**

- Get single subject details

```ruby
  #=> Returns the subject name and a list of books by the subject.
  isbndb_api_client.subject.find(name, options)
    name = `A subject in the Subject's database`
    options = {
      page: 1,
      pageSize: 20
    }
```

- Subjects List

```ruby
  #=> This returns a list of subjects matches the given query.
  isbndb_api_client.subject.batch(query, options)
    query = `A string to search for in the Subject’s database`
    options = {
      page: 1, # for books
      pageSize: 20 # for books
    }
```

- Subjects Search

```ruby
  #=> This returns a list of subjects who's name matches the given query.
  isbndb_api_client.subject.search(options)
    options = {
      page: 1,
      pageSize: 20,
      subject: `A subject in the Subject's database`,
      text: `A string to search for determinate subject database`
    }
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/isbndb-ruby. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the ISBNdb project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/isbndb-ruby/blob/master/CODE_OF_CONDUCT.md).
