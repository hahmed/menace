# frozen_string_literal: true

module AuthorizeDirectUpload
  extend ActiveSupport::Concern

  included do
    before_action :require_authorization
  end

  private
    def require_authorization
      head :forbidden unless authorized?
    end

    def authorized?
      if resource
        @blob.authorize_direct_upload?(resource)
      else
        true
      end
    end

    # what do we need here? Headers? Cookies? Session? Params?
    def resource
      Menace::Current.resource
    end
end
