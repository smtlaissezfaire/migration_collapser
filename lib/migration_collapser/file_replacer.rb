module MigrationCollapser
  class FileReplacer
    PATTERN = /(\d+)\_.+\.rb/

    def initialize(revision)
      self.revision = revision
    end

    attr_reader :revision

    def revision=(num)
      @revision = num.to_i
    end

    def replace
      delete_files
      create_migration
    end

    def delete_files
      files = Dir.glob("db/migrate/*.rb")
      file_map = new_migration_map(files)

      check_files(file_map)

      file_map.each do |file, number|
        if number <= revision
          FileUtils.rm(file)
        end
      end
    end

    def create_migration
      cp "templates/initial_schema_migration.rb", "db/migrate/#{revision}_initial_schema.rb"
    end

  private

    def cp(template, path)
      FileUtils.cp(File.dirname(__FILE__) + "/#{template}", path)
    end

    def check_files(file_map)
      raise "No files in db/migrate" if file_map.empty?

      if file_map.none? { |_, number| number == revision }
        raise "No migration matching revision #{revision}"
      end
    end

    def new_migration_map(files)
      hash = {}

      files.each do |file|
        file =~ PATTERN
        number = $1.to_i

        hash[file] = number
      end

      hash
    end
  end
end