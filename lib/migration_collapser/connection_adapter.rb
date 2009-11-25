module MigrationCollapser
  class ConnectionAdapter
    def file_path
      expand_path(Dir.getwd, "config", "database.yml")
    end

    def params
      YAML.load(File.read(file_path))
    end

  private

    def expand_path(*dirs)
      File.expand_path(join(*dirs))
    end

    def join(*dirs)
      File.join(*dirs)
    end
  end
end
