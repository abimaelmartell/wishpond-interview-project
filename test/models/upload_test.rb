require 'test_helper'

class UploadTest < ActiveSupport::TestCase
  test "validates file type" do
    upload = Upload.new

    upload.file.attach(file_fixture_blob('dummy.pdf'))
    assert_not upload.save

    upload.file.attach(file_fixture_blob('jonas-verstuyft-Pp6efQ_ghiA-unsplash.jpg'))
    assert_not upload.save

    upload.file.attach(file_fixture_blob('logo.png'))
    assert upload.save
  end
end

