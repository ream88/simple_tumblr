require 'active_support/core_ext'
require 'httparty'

class SimpleTumblr
  include Enumerable, HTTParty

  attr_accessor :options
  base_uri 'api.tumblr.com'

  def initialize(options = {})
    self.options = options
  end

  def posts(options = {})
    self.options = self.options.merge(options)
    self
  end

  %w[text quote link answer video audio photo].each do |type|
    define_method(type) do
      posts(type: type)
    end

    define_method(type.pluralize) do
      posts(type: type)
    end
  end

  %w[id limit offset tag type].each do |scope|
    define_method(scope) do |arg|
      posts(scope.to_sym => arg)
    end
  end

  def each(&block)
    options = self.options.dup
    
    response = self.class.get("/v2/blog/#{options.delete(:hostname)}/posts", query: options)
    raise response['meta']['msg'] unless response.success?

    response['response']['posts'].map { |data| Post.new(data) }.each(&block)
  end

  class << self
    def method_missing(method, *args, &block)
      instance = new
      
      if instance.respond_to?(method)
        instance.options = args.extract_options!
        
        if instance.method(method).arity == 1
          instance.send(method, args)
        else
          instance.send(method)
        end
      else
        super
      end
    end
  end

  class Post
    def initialize(data)
      self.data = data.with_indifferent_access
    end

    delegate :inspect, :[], to: :data

    def <=>(other)
      self[:timestamp] <=> other[:timestamp]
    end

    def method_missing(*args)
      method = args.first.to_sym
      data.has_key?(method) ? data[method] : super
    end

    def title
      attribute_presence(:title, :caption, :text)
    end
    alias_method :to_s, :title

    def body
      attribute_presence(:body)
    end

    def url
      attribute_presence(:url, :link_url, :post_url)
    end

  private
    attr_accessor :data

    def attribute_presence(*attributes)
      begin
        attribute = self[attributes.shift]
      end while attribute.blank?
      attribute
    end
  end
end
