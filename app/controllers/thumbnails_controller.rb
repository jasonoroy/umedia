class ThumbnailsController < ActionController::Base
  def update
    upload! if (!item.nil?)
    render plain: "OK"
  end

  def upload!
    Thumbnailer.new(cdn_url: thumb_url.to_cdn_s,
                    thumb_url: thumb_url.to_s).upload!
  end

  def thumb_url
    @thumb_url ||= Umedia::Thumbnail::Url.new(item: item,
                                              viewer_type: viewer_type)
  end

  def viewer_type
    if first_child
      first_child
    else
      item
    end.field_viewer_type.value
  end

  def first_child
    Rails.cache.fetch("first_compound_child/#{id}") do
      Umedia::ChildSearch.new(parent_id: id,
        # Attachments are things like transcripts; these
        # exist only on kaltura records or items that have
        # been explicitly set at the designated attachment.
        # We do not therefore want attachments to be
        # counted in sidebar queries
        include_attachments: false,
        search_config: Parhelion::SearchConfig.new(search_params)).items.first
    end
  end

  # We only need the first row
  def search_params
    {
      page: 0,
      rows: 1,
      fl: 'viewer_type'
    }
  end

  def item
    @item ||=
      Rails.cache.fetch("item/#{id}") do
        Umedia::ItemSearch.new(id: id).item
      end
  end

  def id
    thumbnail_params[:item_id]
  end

  def thumbnail_params
    params.permit(:item_id)
  end
end