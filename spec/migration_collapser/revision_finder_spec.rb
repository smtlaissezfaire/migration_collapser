require "spec_helper"

module MigrationCollapser
  describe RevisionFinder do
    before do
      SchemaMigration.delete_all
    end

    it "should find the revision number" do
      SchemaMigration.create!(:version => "1")
      RevisionFinder.find.should == "1"
    end

    it "should find the correct revision number" do
      SchemaMigration.create!(:version => "2")
      RevisionFinder.find.should == "2"
    end

    it "should find the latest one" do
      SchemaMigration.create!(:version => 2)
      SchemaMigration.create!(:version => 1)

      RevisionFinder.find.should == "2"
    end

    it "should find the latest one independent of creation order" do
      SchemaMigration.create!(:version => 1)
      SchemaMigration.create!(:version => 2)

      RevisionFinder.find.should == "2"
    end
  end
end