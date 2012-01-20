require File.expand_path('../spec_helper', __FILE__)

describe SimpleTumblr do
  let(:tumblr) { SimpleTumblr.new }
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
      SimpleTumblr.posts.must_be_instance_of(SimpleTumblr)
      
      types.each do |type|
        SimpleTumblr.send(type).must_be_instance_of(SimpleTumblr)
      end
      
      scopes.each do |scope|
        SimpleTumblr.send(scope, nil).must_be_instance_of(SimpleTumblr)
      end
    end
  end
end