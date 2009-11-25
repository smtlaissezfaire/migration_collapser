require File.expand_path(File.dirname(__FILE__) + "/../lib/migration_collapser")

begin
  require 'jeweler'

  def set_version_for_jewler
    version = MigrationCollapser::Version::STRING

    File.open(File.expand_path(File.dirname(__FILE__) + "/../VERSION"), "w") do |f|
      f << version
    end
  end

  Jeweler::Tasks.new do |gemspec|
    set_version_for_jewler

    gemspec.name           = "migration_collapser"
    gemspec.summary        = "Collapse rails migrations"
    gemspec.description    = "Collapse migrations already run in production"
    gemspec.email          = "scott@railsnewbie.com"
    gemspec.homepage       = "http://github.com/smtlaissezfaire/migration_collapser"
    gemspec.authors        = ["Scott Taylor"]
    gemspec.add_dependency "using"
  end
rescue LoadError
  puts "Jeweler not available. Install it with: sudo gem install technicalpickles-jeweler -s http://gems.github.com"
end
