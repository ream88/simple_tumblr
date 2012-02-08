require File.expand_path('../spec_helper', __FILE__)

describe SimpleTumblr do
  let(:blog) { 'demo.tumblr.com' }
  let(:tumblr) { SimpleTumblr.new(hostname: blog, api_key: 'F1p5RReaOvJirhsR78JADwC5Iw8h04qSjDGBhOejXySCLtGo3m') }
  let(:types) { %w[text quote link answer video audio photo] }
  let(:scopes) { %w[id limit offset tag type] }

  describe 'types' do
    it 'responds to all types' do
      types.each do |type|
        tumblr.must_respond_to(type)
      end
    end

    it 'responds to all pluralized types' do
      types.map(&:pluralize).each do |type|
        tumblr.must_respond_to(type)
      end
    end
  end

  describe 'scopes' do
    it 'responds to all scopes' do
      scopes.each do |scope|
        tumblr.must_respond_to(scope)
      end
    end
  end

  it 'behaves like an ActiveRecord::Relation object' do
    tumblr.posts.must_equal(tumblr)
    
    types.each do |type|
      tumblr.send(type).must_equal(tumblr)
    end
    
    scopes.each do |scope|
      tumblr.send(scope, nil).must_equal(tumblr)
    end
  end

  describe 'class' do
    it 'delegates types and scopes to SimpleTumblr instance' do
      skip('Stupido Rake::DSL error!')
      
      SimpleTumblr.posts.must_be_instance_of(SimpleTumblr)
      
      types.each do |type|
        SimpleTumblr.send(type).must_be_instance_of(SimpleTumblr)
      end
      
      scopes.each do |scope|
        SimpleTumblr.send(scope, nil).must_be_instance_of(SimpleTumblr)
      end
    end
  end

  describe :each do
    it 'does not remove hostname option' do
      VCR.use_cassette(blog) do
        tumblr.each
        
        tumblr.options.keys.must_include(:hostname)
      end
    end
  end
end