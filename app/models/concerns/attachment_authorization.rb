module AttachmentAuthorization
  def authorize_blob?(object = nil)
    if record.respond_to?(override_authentication_name)
      record.try(override_authentication_name.to_sym, object)
    else
      fallback_authorization(object)
    end
  end

  private

  def fallback_authorization(object)
    record.try(:authorize_blob?, object)
  end

  def override_authentication_name
    @_override_authentication_name ||= "authorize_blob_#{name}?"
  end
end
