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
        execute(sql_line)
      end
    end

    def down
    end

  private

    def drop_view(view_name)
      execute "DROP VIEW IF EXISTS #{view_name}"
    end
  end
end
