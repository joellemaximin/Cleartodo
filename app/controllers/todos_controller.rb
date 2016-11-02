class TodosController < ApplicationController
  before_action :require_login
  before_action :set_todo, only: [:edit, :update, :destroy]

  def index
    set_todos_list
    @todo = Todo.new
  end

  def create
    @todo = current_user.todos.create(todo_params)
    if @todo.save
      redirect_to action: 'index'
    else
      set_todos_list
      render action: 'index'
    end
  end

  def edit
  end

  def update
    if params[:editing_content] == 'true'
      if @todo.update(todo_params)
        redirect_to action: 'index'
      else
        render action: 'edit'
      end
    else
      @todo.update!(todo_params)
      redirect_to action: 'index'
    end
  end

  def destroy
    @todo.destroy
    redirect_to action: 'index'
  end

  private

  def set_todos_list
    @todos_not_completed =
      current_user
      .todos
      .where(completed: false)
      .order(:id)
    @todos_completed =
      current_user
      .todos
      .where(completed: true)
      .order(:id)
  end

  def todo_params
    params.require(:todo).permit(:content, :completed)
  end

  def set_todo
    @todo = current_user.todos.find(params[:id])
  end
end
