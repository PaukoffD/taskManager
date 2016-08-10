class Users::TasksController < ApplicationController
  def index
    if current_user.admin?
      @tasks = Task.all
    else
      @tasks = Task.where(user_id: params[:user_id])
    end
  end

  def state
    @task = Task.find(params[:id])
    @task.state = params[:state]
    @task.save
    redirect_to user_tasks_path, notice: 'Статус задачи обновлён'
  end

  def new
    @task = Task.new
  end

  def show
    @task = Task.find(params[:id])
  end

  def edit
    @task = Task.find(params[:id])
  end

  def create
    @task = Task.new(task_params)

    if @task.save
      redirect_to user_tasks_path, notice: 'Задача создана.'
    else
      render :new
    end
  end

  def update
    @task = Task.find(params[:id])
    authorize @task
    if @task.update(task_params)
      redirect_to user_tasks_path, notice: 'Задача обновлена.'
    else
      render :edit
    end
  end

  def destroy
    @task = Task.find(params[:id])
    authorize @task
    @task.destroy
    redirect_to user_tasks_path, notice: 'Задача удалена.'
  end

  private

  def task_params
    params.require(:task).permit(:name, :description, :state, :file, :user_id)
  end
end
