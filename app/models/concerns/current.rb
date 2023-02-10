class Current < ActiveSupport::CurrentAttributes # :nodoc:
  extend ActiveSupport::Concern

  attr_accessor :resource
end
