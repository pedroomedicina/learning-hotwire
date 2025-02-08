class Projects::MembershipsController < ApplicationController
  before_action :set_project

  def new
  end

  def create
    @project.memberships.create(user_id: params.expect(:user_id))
    redirect_back_or_to @project
  end

  def destroy
    @project.memberships.where(user_id: params.expect(:id)).destroy_all
    redirect_back_or_to @project
  end

  private

  def set_project
    @project = Project.find(params.expect(:project_id))
  end
end
