class Project < ApplicationRecord
  belongs_to :user
  has_one_attached :poster do |attachable|
    attachable.variant :thumbnail, resize_to_limit: [100, 100]
  end
  has_many_attached :files

  def authorize_blob_files?(accessor)
    accessor.id == user_id
  end

  def authorize_blob?(accessor)
    true
  end
end
