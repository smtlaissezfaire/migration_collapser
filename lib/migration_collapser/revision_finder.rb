require 'active_record'

module MigrationCollapser
  class RevisionFinder
    class SchemaInfo < ActiveRecord::Base
      set_table_name "schema_migrations"
    end

    def self.find
      SchemaInfo.find(:first, :order => "version DESC").version
    end
  end
end