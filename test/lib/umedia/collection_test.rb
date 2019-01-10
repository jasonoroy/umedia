require 'test_helper'

module Umedia
  class CollectionTest < ActiveSupport::TestCase
    describe 'when given a setSpec' do
      it 'creates a collection object' do
        collection = Collection.new(set_spec: 'foo:123',
                                    name: 'ul_ugly_thing - blah',
                                    description: 'bar')
        collection.name.must_equal 'ul_ugly_thing - blah'
        collection.display_name.must_equal 'blah'
        collection.description.must_equal 'bar'
        collection.set_spec.must_equal 'foo:123'
      end
    end
  end
end