require 'test_helper'

  class DeleteThumbnailsTest < ActiveSupport::TestCase
    it 'deletes thumbnails and knows if more thumbs may be deleted' do
      bucket = 'bucket-name-here'
      s3_resource = Minitest::Mock.new
      bucket_obj = Minitest::Mock.new
      bucket_obj_obj = Minitest::Mock.new
      thumbs = ["a56c328fc11c3ff503bdabf03845948720298723.png", "a56c328fc11c3ff503bdabf03845948720298723.png", "a56c328fc11c3ff503bdabf03845948720298723.png", "a56c328fc11c3ff503bdabf03845948720298723.png", "a56c328fc11c3ff503bdabf03845948720298723.png", "a56c328fc11c3ff503bdabf03845948720298723.png", "a56c328fc11c3ff503bdabf03845948720298723.png", "a56c328fc11c3ff503bdabf03845948720298723.png", "a56c328fc11c3ff503bdabf03845948720298723.png", "a56c328fc11c3ff503bdabf03845948720298723.png", "a56c328fc11c3ff503bdabf03845948720298723.png", "a56c328fc11c3ff503bdabf03845948720298723.png", "a56c328fc11c3ff503bdabf03845948720298723.png", "a56c328fc11c3ff503bdabf03845948720298723.png", "a56c328fc11c3ff503bdabf03845948720298723.png", "a56c328fc11c3ff503bdabf03845948720298723.png", "a56c328fc11c3ff503bdabf03845948720298723.png", "a56c328fc11c3ff503bdabf03845948720298723.png", "a56c328fc11c3ff503bdabf03845948720298723.png", "a56c328fc11c3ff503bdabf03845948720298723.png", "a56c328fc11c3ff503bdabf03845948720298723.png", "a56c328fc11c3ff503bdabf03845948720298723.png", "a56c328fc11c3ff503bdabf03845948720298723.png", "a56c328fc11c3ff503bdabf03845948720298723.png", "a56c328fc11c3ff503bdabf03845948720298723.png", "a56c328fc11c3ff503bdabf03845948720298723.png", "a56c328fc11c3ff503bdabf03845948720298723.png", "a56c328fc11c3ff503bdabf03845948720298723.png", "a56c328fc11c3ff503bdabf03845948720298723.png", "a56c328fc11c3ff503bdabf03845948720298723.png", "a56c328fc11c3ff503bdabf03845948720298723.png", "a56c328fc11c3ff503bdabf03845948720298723.png", "a56c328fc11c3ff503bdabf03845948720298723.png", "a56c328fc11c3ff503bdabf03845948720298723.png"]
      thumbs.map do |thumb|
        bucket_obj.expect :object, bucket_obj_obj, [thumb]
        bucket_obj_obj.expect :delete, false, []
      end

      s3_resource.expect :bucket, bucket_obj, [bucket]
      deleter = DeleteThumbnails.new(param_string: 'q=libraries',
                                     page: 1,
                                     bucket: bucket,
                                     s3_resource: s3_resource)
      deleter.delete!.must_equal thumbs
      deleter.last_batch?.must_equal false
      s3_resource.verify
    end

    describe 'when no results are returned' do
      it 'signals last batch' do
        bucket = 'bucket-name-here'
        s3_resource = Minitest::Mock.new
        bucket_obj = Minitest::Mock.new
        s3_resource.expect :bucket, bucket_obj, [bucket]
        deleter = DeleteThumbnails.new(param_string: 'q=sdfsdfsdf',
                                       page: 1,
                                       bucket: bucket,
                                       s3_resource: s3_resource)
        deleter.delete!.must_equal []
        deleter.last_batch?.must_equal true
        s3_resource.verify
      end
    end
  end
