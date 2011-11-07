# simple_tumblr

SimpleTumblr's goal is to provide the simplest way to use the [Tumblr API](http://www.tumblr.com/docs/en/api/v2) (read-only). 

## Installation

In your `Gemfile`:

```ruby
gem 'simple_tumblr'
```

## Usage

```ruby
blog = SimpleTumblr.new(api_key: '**************************************************', hostname: 'tumblr.mariouher.com')
```

```ruby
blog.posts.each do |post|
  puts post.body
end
```

### `ActiveRecord::Relation`-like syntax

You can use `ActiveRecord::Relation`-like syntax to get posts from Tumblr. For example, to receive your last five photos tagged 'instagram' you can chain calls like so:

```ruby
blog.photos.tag('instagram').limit(5)
```

or so:

```ruby
blog.tag('instagram').limit(5).photos
```

or if you dont like this syntax you can do this instead:

```ruby
blog.posts(type: 'photo', tag: 'instagram', limit: 5)
```

Following scope methods are defined: `text`, `quote`, `link`, `answer`, `video`, `audio`, `photo` and their corresponding plurals. Additional methods are `id`, `limit`, `offset`, `type` and `tag`.

They are also defined as class methods to enable shortened calls:

```ruby
SimpleTumblr.photos(api_key: '**************************************************', hostname: 'tumblr.mariouher.com')
```

Since SimpleTumblr includes `Enumerable` you can of course sort the posts, find the min/max and even more. Be sure to check out the 
[`Enumerable` docs](http://ruby-doc.org/core-1.9.3/Enumerable.html) for more info.
 
### Posts

Each SimpleTumblr call returns a couple of `SimpleTumblr::Post` objects, which are a nice and convenient wrappers for accessing post's data - for more information be sure to read the [Tumblr API](http://www.tumblr.com/docs/en/api/v2):

```ruby
post = blog.photos.first

post.tags == post[:tags] == post['tags']

# => true
```

`title` (also aliased as `to_s`), `url` and `body` return corresponding data. Calling `link` on link-posts will return the source URL, photo-posts will return the URL of their photo and text-posts will return their Tumblr-URL. This will help you to write clean and easy-to-read views:

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

Copyright (c) 2011 Mario Uher

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