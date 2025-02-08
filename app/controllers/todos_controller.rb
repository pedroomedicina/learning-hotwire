class TodosController < ApplicationController
  def index
    @todos = Current.user.todos
  end
end
