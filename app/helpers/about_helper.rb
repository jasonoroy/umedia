module AboutHelper
  def collections_count
    facet_count('collection_name_s')
  end

  def formats_count
    facet_count('format_name')
  end

  def all_pages_count
    Rails.cache.fetch("all_pages_count", expires_in: 12.hours) do
      count_delimit(Umedia::RecordCountSearch.new(include_children: true).count)
    end
  end

  def count_delimit(count)
    number_with_delimiter(count, delimiter: ',')
  end

  def facet_count(facet)
    Rails.cache.fetch("facet_count_#{facet}", expires_in: 12.hours) do
      count_delimit(Umedia::FacetCountSearch.new(facet: facet).count)
    end
  end
end
