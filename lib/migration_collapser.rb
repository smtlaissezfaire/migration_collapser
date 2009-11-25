require "using"

module MigrationCollapser
  extend Using

  using :Version
  using :RevisionFinder
  using :ConnectionAdapter
  using :RailsLoader
  using :FileReplacer
end
