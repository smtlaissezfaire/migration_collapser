class InitialSchema < ActiveRecord::Migration
  class << self
    def up
      class << connection = ActiveRecord::Base.connection
        def username
          @config[:username]
        end

        def host
          @config[:host]
        end
      end

      file = File.read(File.dirname(__FILE__) + "/initial_schema.sql")

      file.split(";").each do |sql_line|
        execute(sql_line, true)
      end
    end

    def down
      drop_views
      drop_tables
    end

  private

    def execute(sql_string, verbose = false)
      if verbose
        puts "* Executing: #{sql_string}"
      end

      ActiveRecord::Base.connection.execute(sql_string)
    end

    def drop_tables
      tables.each do |table|
        drop_table(table)
      end
    end

    def drop_views
      views.each do |view|
        drop_view(view)
      end
    end

    def drop_table(table_name)
      puts "* Dropping table: #{table_name}"
      execute "DROP TABLE `#{table_name}`"
    end

    def drop_view(table_name)
      puts "* Dropping view: #{table_name}"
      execute "DROP VIEW `#{table_name}`"
    end

    def tables
      @tables ||= all_tables - ["schema_migrations"]
    end

    def all_tables
      execute("SHOW FULL TABLES WHERE table_type = 'VIEW'").all_hashes.map { |x| x.values.last }
    end

    def views
      @views ||= execute("SHOW FULL TABLES WHERE table_type = 'VIEW'").all_hashes.map { |x| x.values.last }
    end
  end
end
