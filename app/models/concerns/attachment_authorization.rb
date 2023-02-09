module AttachmentAuthorization
  extend ActiveSupport::Concern

  def authorize_blob?(object = nil, type: nil)
    return default_authorization(object) unless type

    # todo: validate type? or throw if it does not exist?
    method_name = "authorize_blob_#{type.to_s}?"
    if record.respond_to?(method_name)
      record.try(method_name.to_sym, object)
    else
      default_authorization(object)
    end
  end

  private

  def default_authorization(object)
    record.try(:authorize_blob?, object)
  end
end
