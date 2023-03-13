# frozen_string_literal: true

module DirectUploadAuthorization
  def authorize_direct_upload?(object = nil)
    record.try(:authorize_direct_upload?, object)
  end
end
