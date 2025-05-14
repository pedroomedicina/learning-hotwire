class TodosController < ApplicationController
  def index
    @pagy, @todos = pagy(Current.user.todos)
  end
end
