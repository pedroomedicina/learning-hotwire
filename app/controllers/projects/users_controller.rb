class Projects::UsersController < ApplicationController
  before_action :set_project
  before_action :set_user

  def show
  end

  private

  def set_project
    @project = Current.user.projects.find(params.expect(:project_id))
  end

  def set_user
    @user = @project.users.find(params.expect(:id))
  end
end