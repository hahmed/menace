module BlobAuthorization
  def authorize_blob?(object = nil, type:)
    attachments.includes(:record).any? { |attachment| attachment.authorize_blob?(object, type: type) } || attachments.none?
  end
end
