# frozen_string_literal: true

module Authorize
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
        @blob.authorize_blob?(resource)
      else
        true
      end
    end

    def resource
      Menace::Current.resource
    end
end
