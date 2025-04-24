# frozen_string_literal: true

module Projects
  class NamesController < ApplicationController
    before_action :set_project

    def edit
    end

    def update
      if @project.update(name_params)
        redirect_to @project
      else
        render :edit, status: :unprocessable_entity
      end
    end

    private

    def set_project
      @project = Current.user.projects.find(params.expect(:project_id))
    end

    def name_params
      params.expect(project: [ :name ])
    end
  end
end
