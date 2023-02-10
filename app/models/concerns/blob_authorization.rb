module BlobAuthorization
  def authorize_blob?(object = nil)
    attachments.includes(:record).any? { |attachment| attachment.authorize_blob?(object) } || attachments.none?
  end
end
