module Authorize # nodoc
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
        @blob.accessible_to?(resource)
      else
        true
      end
    end

    def resource
      ActiveStorage::Current.resource
    end
end
