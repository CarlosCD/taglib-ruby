require 'helper'

require 'fileutils'

class TestFileRefWrite < Test::Unit::TestCase

  SAMPLE_FILE = "test/data/sample.mp3"
  OUTPUT_FILE = "test/data/output.mp3"

  context "TagLib::FileRef" do
    setup do
      FileUtils.cp SAMPLE_FILE, OUTPUT_FILE
      @file = TagLib::MPEG::File.new(OUTPUT_FILE, false)
    end

    should "be able to save the title" do
      tag = @file.tag
      assert_not_nil tag
      tag.title = "New Title"
      success = @file.save
      assert success
      @file.close
      @file = nil

      written_file = TagLib::MPEG::File.new(OUTPUT_FILE, false)
      assert_equal "New Title", written_file.tag.title
      written_file.close
    end

    teardown do
      if @file
        @file.close
        @file = nil
      end
      FileUtils.rm OUTPUT_FILE
    end
  end
end
