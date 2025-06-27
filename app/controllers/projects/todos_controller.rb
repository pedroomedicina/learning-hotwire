class Projects::TodosController < ApplicationController
  before_action :set_project
  before_action :set_todo, only: [ :show, :edit, :update, :destroy ]

  def show
  end

  def new
    @todo = @project.todos.new
  end

  def create
    @todo = @project.todos.new(todo_params)

    respond_to do |format|
      if @todo.save
        format.html { redirect_to @project }
        format.turbo_stream
      else
        format.html { render :new, status: :unprocessable_entity }
        format.turbo_stream { render :new }
      end
    end
  end

  def edit
  end

  def update
    if @todo.update(todo_params)
      redirect_back_or_to @project
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @todo.destroy
    redirect_to @project, status: :see_other, notice: "Todo successfully deleted!"
  end

  private

  def set_todo
    @todo = Todo.find(params.expect(:id))
  end

  def set_project
    @project = Project.find(params.expect(:project_id))
  end

  def todo_params
    params.expect(todo: [ :name, :description, :due_date, :completed, :user_id ])
  end
end
