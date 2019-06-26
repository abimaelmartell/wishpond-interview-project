require 'test_helper'

class PlayTest < ActiveSupport::TestCase
  setup do
    @upload = Upload.new
    @upload.file.attach(file_fixture_blob('logo.png'))
    @upload.save
  end

  test "validates presence of timer" do
    play = Play.new
    play.upload = @upload
    assert_not play.save

    play.timer = 1
    assert play.save
  end

  test "validates presence of upload" do
    play = Play.new
    play.timer = 1
    assert_not play.save

    play.upload = @upload
    assert play.save
  end
end
