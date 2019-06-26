class PlaysControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get plays_path

    assert_response :success
  end

  test "shoud create plays" do
    upload = Upload.new
    upload.file.attach(file_fixture_blob('logo.png'))
    upload.save

    play_params = {
      play: {
        timer: 1,
        upload_id: upload.id
      }
    };

    post plays_path, params: play_params, as: :json
    assert_response :success
  end
end

