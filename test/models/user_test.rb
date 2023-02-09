require "test_helper"

class UserTest < ActiveSupport::TestCase
  def setup
    file_name = File.join(fixture_path, "files/1x1.png")
    @blob = ActiveStorage::Blob.create_and_upload!(io: File.open(file_name), filename: "1x1.png", content_type: "image/png")
  end

  test "user can access blob when authorized when override defined" do
    klass = Class.new(User) do
      def authorize_blob?(accessor)
        true
      end
    end
    user = klass.new(avatar: @blob)
    assert user.avatar.authorize_blob?(user)
  end

  test "user cannot access blob when authorized" do
    user = User.new(avatar: @blob)
    refute user.avatar.authorize_blob?(user)
  end

  test "user cannot access blob when authorize_blob? is false" do
    klass = Class.new(User) do
      def authorize_blob?(accessor)
        false
      end
    end

    user = klass.new(avatar: @blob)
    refute user.avatar.authorize_blob?(user)
  end

  test "user can acess blob when inflection method is true" do
    klass = Class.new(User) do
      def authorize_blob_avatar?(accessor)
        true
      end
    end

    user = klass.new(avatar: @blob)
    assert user.avatar.authorize_blob?(user, type: :avatar)
  end
end
