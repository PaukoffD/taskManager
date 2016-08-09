class Users::TasksController < ApplicationController
  def index
    @tasks = Task.where(user_id: params[:user_id])
  end

  def new
    @task = Task.new
  end

  def edit
    @task = Task.find(params[:id])
  end

  def create
    @task = Task.new(task_params)
    @task.user_id = params[:user_id]
    if @task.save
      redirect_to user_tasks_path, notice: 'Задача создана.'
    else
      render :new
    end
  end

  def update
    @task = Task.find(params[:id])

    if @task.update(task_params)
      redirect_to edit_user_task_path(current_user, @task), notice: 'Задача обновлена.'
    else
      render :edit
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    redirect_to user_tasks_path, notice: 'Задача удалена.'
  end

  private

  def task_params
    params.require(:task).permit(:name, :description, :state, :user_id)
  end
end
