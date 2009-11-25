require "using"

module MigrationCollapser
  extend Using

  using :Version
  using :RevisionFinder
  using :RailsLoader
  using :FileReplacer
end
