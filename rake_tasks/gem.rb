require File.expand_path(File.dirname(__FILE__) + "/../lib/prototype_project")

begin
  require 'jeweler'

  def set_version_for_jewler
    version = PrototypeProject::Version::STRING

    File.open(File.expand_path(File.dirname(__FILE__) + "/../VERSION"), "w") do |f|
      f << version
    end
  end

  Jeweler::Tasks.new do |gemspec|
    set_version_for_jewler

    gemspec.name           = "the-perfect-gem"
    gemspec.summary        = "Summarize your gem"
    gemspec.description    = "Describe your gem"
    gemspec.email          = "scott@railsnewbie.com"
    gemspec.homepage       = "http://github.com/smtlaissezfaire/the-perfect-gem"
    gemspec.authors        = ["Scott Taylor"]
    gemspec.add_dependency "using", ">= 1.0.5"
  end
rescue LoadError
  puts "Jeweler not available. Install it with: sudo gem install technicalpickles-jeweler -s http://gems.github.com"
end
