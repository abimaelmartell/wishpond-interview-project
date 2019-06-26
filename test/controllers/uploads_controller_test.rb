class UploadsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get uploads_path

    assert_response :success
  end

  test "shoud be able to upload multiple files" do
    post uploads_path, params: {
      upload: {
        file: [
          fixture_file_upload('files/Integrations2.jpg'),
          fixture_file_upload('files/logo.png')
        ]
      }
    }

    assert_response :redirect
    assert flash[:error].nil?
  end
end
