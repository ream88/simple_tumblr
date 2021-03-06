# SimpleTumblr

SimpleTumblr's goal is to provide the simplest way to use the [Tumblr API](http://www.tumblr.com/docs/en/api/v2) (read-only). 

[![Build Status](https://secure.travis-ci.org/haihappen/simple_tumblr.png)](http://travis-ci.org/haihappen/simple_tumblr)

## Installation

In your `Gemfile`:

```ruby
gem 'simple_tumblr'
```

## Usage

```ruby
blog = SimpleTumblr.new(api_key: '**********', hostname: 'tumblr.mariouher.com')

blog.posts.each do |post|
  puts post
end
```

## Features

### Simple Syntax

You can use sexy `ActiveRecord::Relation`-like syntax to get posts from Tumblr. For example, to receive your last five photos tagged `'instagram'` you can chain calls like so:

```ruby
blog.photos.tag('instagram').limit(5)

# or so (random order):
blog.tag('instagram').limit(5).photos

# or if you dont like this syntax you can do this instead:
blog.posts(type: 'photo', tag: 'instagram', limit: 5)
```

Following scope methods are defined: `text`, `quote`, `link`, `answer`, `video`, `audio`, `photo` and their corresponding plurals. They are also defined as class methods to enable even shorter calls:

```ruby
SimpleTumblr.photos(api_key: '**********', hostname: 'tumblr.mariouher.com', tag: 'instagram', limit: 5)
```

Additional scoping methods are `id`, `limit`, `offset`, `tag` and `type`.

### Enumerable

Since SimpleTumblr includes `Enumerable` you can of course sort the posts, find the minimum or maximum and do even more fancy stuff you can do with Enumerables. Be sure to check out the [Enumerable docs](http://ruby-doc.org/core-1.9.3/Enumerable.html) for more info.
 
### Simple Wrapper

Each SimpleTumblr call returns a couple of `SimpleTumblr::Post` objects, which are a nice and convenient wrappers for accessing post attributes. These attributes are defined by Tumblr's API and shared across the post objects, for a detailed list and more information about them be sure to read the [Tumblr API](http://www.tumblr.com/docs/en/api/v2). Since `SimpleTumblr::Post`'s are acting like hashes, you can access attributes using square brackets and a string or symbol as key. Or if you are like me, you will love the option to access them via methods on the `SimpleTumblr::Post` object. See the example below for the usage:

```ruby
post = blog.photos.first

post['tags'] == post[:tags] == post.tags
# => true
```

Following methods – `title` (also aliased as `to_s`), `url` and `body` – are defined to allow you easily iterating through a bunch of posts in your ERB/HAML/whatever views. 

TODO: Add more information.

Calling `url` on link-posts will return the source URL, photo-posts will return the URL of their photo and text-posts will return their Tumblr-URL. This will help you to write clean and easy-to-read views:

```erb
<% blog.posts.each do |post| %>
  <h1><%= link_to(post, post.url) %></h1>
  
  <%= post.body %>
<% end %>
```

## Contributing to simple_tumblr
 
* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet
* Check out the [issue tracker](https://github.com/haihappen/simple_tumblr/issues) to make sure someone already hasn't requested it and/or contributed it
* Fork the project
* Start a feature/bugfix branch
* Commit and push until you are happy with your contribution
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

## Copyright

(The MIT license)

Copyright (c) 2011-2012 Mario Uher

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.