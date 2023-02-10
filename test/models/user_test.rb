require "test_helper"

class UserTest < ActiveSupport::TestCase
  def setup
    file_name = File.join(fixture_path, "files/1x1.png")
    @blob = ActiveStorage::Blob.create_and_upload!(io: File.open(file_name), filename: "1x1.png", content_type: "image/png")
    @another_blob = ActiveStorage::Blob.create_and_upload!(io: File.open(file_name), filename: "1x1.png", content_type: "image/png")
  end

  test "user is authorized when override defined" do
    klass = Class.new(User) do
      def authorize_blob?(accessor)
        true
      end
    end
    user = klass.new(avatar: @blob)
    assert user.avatar.authorize_blob?
  end

  test "user unauthorized when no override defined" do
    user = User.new(avatar: @blob)
    refute user.avatar.authorize_blob?
  end

  test "user unauthorized when default override returns false" do
    klass = Class.new(User) do
      def authorize_blob?(accessor)
        false
      end
    end

    user = klass.new(avatar: @blob)
    refute user.avatar.authorize_blob?
  end

  test "user authorized when override returns true" do
    klass = Class.new(User) do
      def authorize_blob_avatar?(accessor)
        true
      end
    end

    user = klass.new(avatar: @blob)
    assert user.avatar.authorize_blob?
  end

  test "user unauthorized for cover_photo when override returns true" do
    klass = Class.new(User) do
      def authorize_blob_avatar?(accessor)
        true
      end
    end

    user = klass.new(avatar: @blob)
    assert user.avatar.authorize_blob?
    refute user.cover_photo.authorize_blob?
  end

  test "user authorized for both blobs when overrides returns true" do
    klass = Class.new(User) do
      def authorize_blob?(accessor)
        true
      end
    end

    user = klass.new(avatar: @blob, cover_photo: @another_blob)
    assert user.avatar.authorize_blob?
    assert user.cover_photo.authorize_blob?
  end

  test "user authorized for cover_photo when default override returns true" do
    klass = Class.new(User) do
      def authorize_blob_avatar?(accessor)
        true
      end

      def authorize_blob?(accessor)
        true
      end
    end

    user = klass.new(avatar: @blob, cover_photo: @another_blob)
    assert user.avatar.authorize_blob?
    assert user.cover_photo.authorize_blob?
  end
end
