module MigrationCollapser
  module RailsLoader
    class << self
      def load
        require expand_path(Dir.getwd, "config", "environment")
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
end
