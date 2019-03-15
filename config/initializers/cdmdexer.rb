module CDMDEXER
  class CompletedCallback
    def self.call!(solr_client)
      Rails.logger.info "Completed: #{solr_client.inspect}"
    end
  end

  class OaiNotification
    def self.call!(location)
      Rails.logger.info "CDMDEXER: Requesting: #{location}"
    end
  end

  class CdmNotification
    def self.call!(collection, id, endpoint)
      Rails.logger.info "CDMDEXER: Requesting: #{collection}:#{id} from #{endpoint}"
    end
  end

  # An example callback
  class LoaderNotification
    def self.call!(ingestables, deletables)
      Rails.logger.info "CDMDEXER: Loading #{ingestables.length} records and deleting #{deletables.length}"
    end
  end
end