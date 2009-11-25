require "spec_helper"

module MigrationCollapser
  describe RailsLoader do
    before do
      @loader = RailsLoader
    end

    it "should load Dir.getwd + /config/environment.rb" do
      @loader.should_receive(:require).with(File.expand_path(Dir.getwd) + "/config/environment")
      @loader.load
    end
  end
end