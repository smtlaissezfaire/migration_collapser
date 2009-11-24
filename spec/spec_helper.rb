require "spec"
require File.expand_path(File.dirname(__FILE__) + "/../lib/migration_collapser")

require 'mysql'
require 'active_record'

db_file = File.dirname(__FILE__) + "/mysql_connection.yml"
ActiveRecord::Base.establish_connection YAML.load(File.read(db_file))
ActiveRecord::Migration.verbose = false

ActiveRecord::Schema.define do
  create_table :schema_migrations, :force => true do |t|
    t.string :version
  end
end

class SchemaMigration < ActiveRecord::Base
  validates_presence_of :version
end