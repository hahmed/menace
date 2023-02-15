# frozen_string_literal: true

require "test_helper"

class RedirectControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = User.create!(avatar: create_blob)
    Menace::Current.resource = @user
  end

  teardown { Menace::Current.reset }

  test "controller includes setblob concern" do
    assert ActiveStorage::Blobs::RedirectController.ancestors.include?(ActiveStorage::SetBlob)
    assert ActiveStorage::Representations::RedirectController.ancestors.include?(ActiveStorage::SetBlob)
  end

  test "returns redirect response when undefined override" do
    blob = create_blob
    get rails_blob_path(blob)
    assert_redirected_to(/1x1\.png/)
  end

  test "returns forbidden response when default override returns false" do
    User.any_instance.stubs(:authorize_blob?).returns(false)

    get rails_blob_path(@user.avatar)

    assert_response :forbidden
  end

  test "returns forbidden response when override returns false" do
    User.any_instance.stubs(:authorize_blob_avatar?).returns(false)

    get rails_blob_path(@user.avatar)
    assert_response :forbidden
  end

  test "redirects successfully when default override returns true" do
    User.any_instance.stubs(:authorize_blob?).returns(true)

    get rails_blob_path(@user.avatar)
    assert_redirected_to(/1x1\.png/)
  end

  test "redirects successfully when override returns true" do
    User.any_instance.stubs(:authorize_blob_avatar?).returns(true)

    get rails_blob_path(@user.avatar)
    assert_redirected_to(/1x1\.png/)
  end

  test "redirects successfully when override returns true for cover_photo" do
    User.any_instance.stubs(:authorize_blob_avatar?).returns(false)
    User.any_instance.stubs(:authorize_blob?).returns(true)
    @user.update!(cover_photo: create_blob)

    get rails_blob_path(@user.cover_photo)
    assert_redirected_to(/1x1\.png/)
  end

  private

  def create_blob
    file = File.join(fixture_path, "files/1x1.png")
    ActiveStorage::Blob.create_and_upload!(io: File.open(file), filename: "1x1.png", content_type: "image/png")
  end
end
