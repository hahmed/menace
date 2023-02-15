class ProjectController < ApplicationController
  before_action :assign_admin
  before_action :assign_active_storage_resource

  def index
    @projects = Project.all
  end

  private

  def assign_active_storage_resource
    Menace::Current.resource = admin
  end

  def assign_admin
    admin || raise("No admin found")
  end

  def admin
    @_admin ||= User.first
  end
end
