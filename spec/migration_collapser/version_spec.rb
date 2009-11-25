require "spec_helper"

describe MigrationCollapser do
  describe "VERSION" do
    it "should be at 0.0.0" do
      MigrationCollapser::Version::STRING.should == "0.1.1"
    end

    it "should have major as 0" do
      MigrationCollapser::Version::MAJOR.should == 0
    end

    it "should have minor as 0" do
      MigrationCollapser::Version::MINOR.should == 1
    end

    it "should have tiny as 0" do
      MigrationCollapser::Version::TINY.should == 1
    end
  end
end
