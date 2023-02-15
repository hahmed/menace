class Project < ApplicationRecord
  belongs_to :user
  has_one_attached :poster, variant :thumbnail, resize_to_limit: [100, 100]
  has_many_attached :files

  def authorize_blob_files?(accessor)
    accessor.id == user_id
  end

  def authorize_blob?(accessor)
    true
  end
end
