require 'vcr'
require 'webmock'

VCR.configure do |c|
  c.cassette_library_dir = 'spec/support/cassettes'
  c.hook_into :webmock
end