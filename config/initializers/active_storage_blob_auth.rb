Rails.application.config.to_prepare do
  ActiveStorage::Blob.include BlobAuthorization
  ActiveStorage::Blob.include DirectUploadAuthorization
  ActiveStorage::Attachment.include AttachmentAuthorization
  ActiveStorage::Blobs::RedirectController.include Authorize
  ActiveStorage::Blobs::ProxyController.include Authorize
  ActiveStorage::Representations::RedirectController.include Authorize
  ActiveStorage::Representations::ProxyController.include Authorize
  ActiveStorage::DirectUploadsController.include AuthorizeDirectUpload
end
