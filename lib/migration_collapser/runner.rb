module MigrationCollapser
  class Runner
    def self.run
      RailsLoader.load
      revision_num = RevisionFinder.find
      FileReplacer.new(revision_num).replace
    end
  end
end