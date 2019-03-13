class ViewersController < ApplicationController
  def show
    render layout: false,
           locals: { viewer_item: viewer_item }
  end

  def viewer_item
    @viewer_doc ||=
      Parhelion::Viewers::Map.new(item: active_doc,
                                  viewer_type: viewer_type).to_viewer
  end

  def active_doc
    if child_id
      item(child_id)
    elsif primary_item.is_compound?
      children.first
    else
      primary_item
    end
  end

  def item(id)
    Rails.cache.fetch("item/#{id}") do
      Umedia::ItemSearch.new(id: id).item
    end
  end

  def viewer_type
    if first_child
      first_child
    else
      primary_item
    end.field_viewer_type.value
  end

  def first_child
    Rails.cache.fetch("first_compound_child/#{params.fetch(:id)}") do
      Umedia::ChildSearch.new(parent_id: params.fetch(:id),
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

  def primary_item
    @primary_item ||= item(params.fetch(:id))
  end

  def child_id
    params.fetch(:child_id, false)
  end
end
