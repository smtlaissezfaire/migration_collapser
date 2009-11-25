require "spec_helper"

module MigrationCollapser
  describe ConnectionAdapter do
    before do
      @adapter = ConnectionAdapter.new
    end

    describe "database.yml" do
      it "should have the file in the working directory" do
        @adapter.file_path.should == File.expand_path(Dir.getwd + "/config/database.yml")
      end
    end

    describe "yaml" do
      before do
        File.stub!(:read).and_return "a-file"
        YAML.stub!(:load).and_return {}
      end

      it "should read the File" do
        File.should_receive(:read).with(@adapter.file_path).and_return "a-yaml-file"
        @adapter.params
      end

      it "should load the yaml" do
        File.stub!(:read).and_return "a-yaml-file"
        YAML.should_receive(:load).with("a-yaml-file").and_return {}
        @adapter.params
      end
    end
  end
end