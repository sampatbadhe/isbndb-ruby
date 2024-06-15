module Helpers
  def isbndb_mock(request, query_params: '')
    endpoint = standard_endpoints(request)
    data_file = File.new(filename_to_path_json(endpoint))
    WebMock
      .stub_request(:get, endpoint_to_url(endpoint + query_params))
      .to_return(body: data_file, status: 200, headers: { 'Content-Type' => 'application/json' })
  end

  def isbndb_mock_raise_error(request, status: 400, query_params: '')
    endpoint = standard_endpoints(request) || request
    WebMock
      .stub_request(:get, endpoint_to_url(endpoint + query_params))
      .to_return(body: '', status: status, headers: { 'Content-Type' => 'application/json' })
  end

  private

  def filename_to_path_json(filenames)
    filename_to_path([filenames].flatten.join.chomp('/') + '.json')
  end

  def filename_to_path(filename)
    isbndb_stub_path = ROOT.join('spec', 'stub_responses')
    File.new(isbndb_stub_path.join(filename))
  end

  def endpoint_to_url(endpoint)
    isbndb_url = 'https://api2.isbndb.com/'
    [isbndb_url, endpoint].join
  end

  def standard_endpoints(lookup)
    {
      author:           'author/',
      authors:          'authors/',
      author_search:    'search/authors/',
      book:             'book/',
      books:            'books/',
      book_search:      'search/books/',
      publisher:        'publisher/',
      publishers:       'publishers/',
      publisher_search: 'search/publishers/',
      subject:          'subject/',
      subjects:         'subjects/',
      subject_search:   'search/subjects/',
      stats:            'stats'
    }[lookup.to_sym]
  end
end
