module Umedia
  class FirstViewerType
    attr_reader :primary_id
    def initialize(primary_id: :MISSING_ID,
                   search_klass: Umedia::ChildSearch,
                   search_config_klass: Parhelion::SearchConfig)
      @primary_id = primary_id
      @search_klass = search_klass
      @search_config_klass = search_config_klass
    end

    def viewer_type
      if item.field_page_count > 1
        first_child
      else
        item
      end.field_viewer_type.value
    end

    def first_child
      Rails.cache.fetch("first_child/#{primary_id}") do
        search_klass.new(
          parent_id: id,
          # Attachments are things like transcripts; these
          # exist only on kaltura records or items that have
          # been explicitly set at the designated attachment.
          # We do not therefore want attachments to be
          # counted in sidebar queries
          include_attachments: false,
          search_config: child_search_config).items.first
        end
    end

    # We only need the first row
    def child_search_config
      Parhelion::SearchConfig.new(page: 0, rows: 1, fl: 'viewer_type')
    end

    def item
      @item ||=
        Rails.cache.fetch("item/#{primary_id}") do
          Umedia::ItemSearch.new(id: primary_id).item
        end
    end
  end
end
