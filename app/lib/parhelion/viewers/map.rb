# frozen_string_literal: true

module Parhelion
  module Viewers
    # Convert a Parhelion item into a viewer
    class Map
      attr_reader :item, :viewer_type
      def initialize(item: Item.new, viewer_type: :MISSING_TYPE)
        @item = item
        @viewer_type = viewer_type
      end

      def to_viewer
        mappings.fetch(viewer_type)
      end

      private

      def mappings
        {
          'image' => OpenSeadragon.new(item: item),
          'pdf' => PDF.new(item: item),
          'kaltura_audio' =>
            kaltura_single(item.field_kaltura_audio.value),
          'kaltura_audio_playlist' =>
            kaltura_compound(item.field_kaltura_audio_playlist.value),
          'kaltura_video' =>
            kaltura_single(item.field_kaltura_video.value),
          'kaltura_video_playlist' =>
            kaltura_compound(item.field_kaltura_video_playlist.value),
          'kaltura_combo_playlist' =>
            kaltura_compound(item.field_kaltura_combo_playlist.value)
        }
      end

      def kaltura_single(entry_id)
        KalturaSingle.new(entry_id: entry_id, item: item)
      end

      def kaltura_compound(entry_id)
        KalturaCompound.new(entry_id: entry_id, item: item)
      end
    end
  end
end