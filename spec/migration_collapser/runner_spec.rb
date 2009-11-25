require "spec_helper"

module MigrationCollapser
  describe Runner do
    before do
      RailsLoader.stub!(:load)
      RevisionFinder.stub!(:find).and_return "1234"

      @replacer = mock 'replacer', :replace => true
      FileReplacer.stub!(:new).and_return @replacer
    end

    it "should load rails" do
      RailsLoader.should_receive(:load)
      Runner.run
    end

    it "should find the revision" do
      RevisionFinder.should_receive(:find).and_return "1234"
      Runner.run
    end

    it "should instantiate a file replacer" do
      FileReplacer.should_receive(:new).and_return @replacer
      Runner.run
    end

    it "should instantiate the file replacer with the revision number" do
      RevisionFinder.stub!(:find).and_return "1234"
      FileReplacer.should_receive(:new).with("1234").and_return @replacer
      Runner.run
    end

    it "should use the correct revision number" do
      RevisionFinder.stub!(:find).and_return "1111"
      FileReplacer.should_receive(:new).with("1111").and_return @replacer
      Runner.run
    end

    it "should replace the files" do
      @replacer.should_receive(:replace)
      Runner.run
    end
  end
end