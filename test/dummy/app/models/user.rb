class User < ApplicationRecord
  has_one_attached :avatar
  has_one_attached :cover_photo
  has_many_attached :documents

  has_many :projects
end
