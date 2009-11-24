require "spec_helper"

describe PrototypeProject do
  describe "VERSION" do
    it "should be at 0.0.0" do
      PrototypeProject::Version::STRING.should == "0.0.0"
    end

    it "should have major as 0" do
      PrototypeProject::Version::MAJOR.should == 0
    end

    it "should have minor as 0" do
      PrototypeProject::Version::MINOR.should == 0
    end

    it "should have tiny as 0" do
      PrototypeProject::Version::TINY.should == 0
    end
  end
end
