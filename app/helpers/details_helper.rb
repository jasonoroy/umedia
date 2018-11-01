module DetailsHelper
  def field_sections
    [
      {
        fields: [
          { name: 'title' },
          { name: 'alternative_title' },
          { name: 'description' },
          { name: 'date_created_ss', facet: true },
          { name: 'historical_era' },
          { name: 'creator_ss', facet: true },
          { name: 'contributor', facet: true },
          { name: 'publisher' },
          { name: 'caption' },
          { name: 'notes' }
        ]
      },
      {
        label: 'Physical Description',
        fields: [
          { name: 'types', facet: 'types' },
          { name: 'format_name', facet: true },
          { name: 'dimensions' },
        ]
      },
      {
        label: 'Topics',
        fields: [
          { name: 'subject_ss', facet: true },
          { name: 'subject_fast_ss', facet: true },
          { name: 'language', facet: true }
        ]
      },
      {
        label: 'Geographic Details',
        fields: [
          { name: 'city', facet: true },
          { name: 'state', facet: true },
          { name: 'country', facet: true },
          { name: 'region', facet: true },
          { name: 'continent', facet: true },
          { name: 'geonames' },
          { name: 'projection' },
          { name: 'scale' }
        ]
      },
      {
        label: 'Collection Information',
        fields: [
          { name: 'parent_collection_name', facet: true  },
          { name: 'contributing_organization_name', facet: true },
          { name: 'contact_information' },
          { name: 'fiscal_sponsor' }
        ]
      },
      {
        label: 'Identifiers',
        fields: [
          { name: 'local_identifier' },
          { name: 'barcode' },
          { name: 'system_identifier' },
          { name: 'dls_identifier' },
          { name: 'persistent_url' }
        ]
      },
      {
        label: 'Can I use It?',
        fields: [
          { name: 'local_rights' },
          { name: 'standardized_rights' },
          { name: 'rights_statement_uri' }
        ]
      },
      {
        fields: [
          { name: 'transcription' },
          { name: 'translation' }
        ]
      }
    ]
  end
end
