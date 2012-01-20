# encoding: utf-8
require './lib/simple_tumblr/version'

Gem::Specification.new do |s|
  s.name         = 'simple_tumblr'
  s.version      = SimpleTumblr::VERSION
  s.author       = 'Mario Uher'
  s.email        = 'uher.mario@gmail.com'
  s.homepage     = 'https://www.github.com/haihappen/simple_tumblr'
  s.description  = s.summary = 'SimpleTumblr provides a simple – ActiveRecord::Relation like – way to interact with the Tumblr API.'

  s.files        = Dir.glob('lib/**/*')
  s.require_path = 'lib'

  s.add_dependency('activesupport', '~> 3.0')
  s.add_dependency('httparty')

  s.add_development_dependency('minitest')
  s.add_development_dependency('purdytest')
  s.add_development_dependency('rake', '~> 0.8.0')
  s.add_development_dependency('vcr')
  s.add_development_dependency('webmock')
end