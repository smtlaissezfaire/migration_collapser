require "spec_helper"
require "fakefs/spec_helpers"

module MigrationCollapser
  describe FileReplacer do
    describe "replace" do
      before do
        @replacer = FileReplacer.new("revision")
        @replacer.stub!(:delete_files)
        @replacer.stub!(:create_migration)
      end

      it "should call delete_files" do
        @replacer.should_receive(:delete_files)
        @replacer.replace
      end

      it "should call create_migration" do
        @replacer.should_receive(:create_migration)
        @replacer.replace
      end
    end

    def setup_rails
      Dir.mkdir "/rails_root"
      Dir.mkdir "/rails_root/db"
      Dir.mkdir "/rails_root/db/migrate"

      Dir.chdir "/rails_root"
    end

    describe "deleting files" do
      include FakeFS::SpecHelpers

      before do
        setup_rails

        @revision = 123456
        @replacer = FileReplacer.new(@revision)
      end

      it "should raise an error if it has no files" do
        lambda {
          @replacer.delete_files
        }.should raise_error("No files in db/migrate")
      end

      it "should delete the file if it it exists" do
        FileUtils.touch "/rails_root/db/migrate/123456_my_migration.rb"
        @replacer.delete_files
        File.exists?("/rails_root/db/migrate/123456_my_migration.rb").should be_false
      end

      it "should delete the migration with any name" do
        FileUtils.touch "/rails_root/db/migrate/123456_foo_bar.rb"
        @replacer.delete_files
        File.exists?("/rails_root/db/migrate/123456_foo_bar.rb").should be_false
      end

      it "should delete the migration with the correct number" do
        @replacer.revision = 123
        FileUtils.touch "/rails_root/db/migrate/123_foo_bar.rb"
        @replacer.delete_files
        File.exists?("/rails_root/db/migrate/123_foo_bar.rb").should be_false
      end

      it "should delete all the migrations before (and including) the given number" do
        @replacer.revision = 002

        FileUtils.touch "/rails_root/db/migrate/001_foo_bar.rb"
        FileUtils.touch "/rails_root/db/migrate/002_foo_bar.rb"

        @replacer.delete_files

        File.exists?("/rails_root/db/migrate/001_foo_bar.rb").should be_false
        File.exists?("/rails_root/db/migrate/002_foo_bar.rb").should be_false
      end

      it "should not delete migrations before the number" do
        @replacer.revision = 2

        FileUtils.touch "/rails_root/db/migrate/001_foo_bar.rb"
        FileUtils.touch "/rails_root/db/migrate/002_foo_bar.rb"
        FileUtils.touch "/rails_root/db/migrate/003_foo_bar.rb"

        @replacer.delete_files

        File.exists?("/rails_root/db/migrate/001_foo_bar.rb").should be_false
        File.exists?("/rails_root/db/migrate/002_foo_bar.rb").should be_false
        File.exists?("/rails_root/db/migrate/003_foo_bar.rb").should be_true
      end

      it "should raise an error if the file does not exist" do
        FileUtils.touch "/rails_root/db/migrate/0001_my_migration.rb"

        @replacer.revision = 123

        lambda {
          @replacer.delete_files
        }.should raise_error
      end
    end

    describe "replacing the migration" do
      before do
        @replacer = FileReplacer.new(1234)
        @file = File.expand_path(File.dirname(__FILE__) + "/../../lib/migration_collapser/templates/initial_schema_migration.rb")
      end

      it "should copy the contents of the default migration" do
        FileUtils.should_receive(:cp).with(@file, "db/migrate/999_initial_schema.rb")
        @replacer.revision = 999

        @replacer.create_migration
      end
    end

    describe "revision" do
      it "should have it as an int when assigned in the constructor" do
        FileReplacer.new("1234").revision.should == 1234
      end

      it "should cast it to an int when provided through the accessor" do
        replacer = FileReplacer.new("1234")
        replacer.revision = "1111"
        replacer.revision.should == 1111
      end
    end
  end
end