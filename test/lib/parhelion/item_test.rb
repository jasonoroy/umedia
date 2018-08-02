require 'test_helper'
module Parhelion
  class ItemTest < ActiveSupport::TestCase
    describe 'when it has no parent id' do
      it 'is its own parent' do
        doc_hash = { 'id' => 'fooCollection:1235' }
        item = Item.new(doc_hash: doc_hash)
        item.parent_id.must_equal(doc_hash['id'].split(':').last)
      end
    end

    describe 'when it has a parent id' do
      it 'is its own parent' do
        doc_hash = { 'id' => 'fooCollection:1235', 'parent_id' => 'fooCollection:1232' }
        item = Item.new(doc_hash: doc_hash)
        item.parent_id.must_equal(doc_hash['parent_id'].split(':').last)
      end
    end

    describe 'when given a hash of field data' do
      it 'knows its IDs' do
        doc_hash = { 'id' => 'fooCollection:123', 'title' => 'foo', 'creator' => %w[blah blergh] }
        item = Item.new(doc_hash: doc_hash)
        item.id.must_equal('123')
        item.collection.must_equal('fooCollection:123')
      end

      it 'knows that it is a compound' do
        doc_hash = { 'title' => 'foo', 'creator' => %w[blah blergh] }
        item = Item.new(doc_hash: doc_hash)
        item.is_compound?.must_equal(false)
      end

      it 'knows that it is a compound' do
        doc_hash = { 'title' => 'foo', 'creator' => %w[blah blergh], 'types' => ['Still Image'] }
        item = Item.new(doc_hash: doc_hash)
        item.type.must_equal('Still Image')
      end

      it 'responds with a field when given a message prefixed with "field"' do
        doc_hash = { 'title' => 'foo', 'creator' => %w[blah blergh] }
        item = Item.new(doc_hash: doc_hash)
        item.field_title.must_equal(Field.new(value: 'foo', name: 'title'))
      end

      describe 'when given a field name that does not exist' do
        it 'responds with a an empty field' do
          doc_hash = { 'title' => 'foo', 'creator' => %w[blah blergh] }
          item = Item.new(doc_hash: doc_hash)
          item.field_not_gonna_happen.must_be_kind_of(MissingField)
          item.field_not_gonna_happen.missing?.must_equal true
          item.field_not_gonna_happen.exists?.must_equal false
        end
      end
    end
  end
end
