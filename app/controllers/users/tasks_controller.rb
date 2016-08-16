class Users::TasksController < ApplicationController
  before_action :get_task, only: [:state, :show, :edit, :update, :destroy]

  def index
    if current_user.admin?
      @tasks = Task.all
    else
      @tasks = Task.where(user_id: params[:user_id])
    end
  end

  def state
    @task.state = params[:state]
    @task.save
    redirect_to user_tasks_path, notice: 'Статус задачи обновлён'
  end

  def new
    @task = Task.new
  end

  def show
  end

  def edit
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
    authorize @task
    if @task.update(task_params)
      redirect_to user_tasks_path, notice: 'Задача обновлена.'
    else
      render :edit
    end
  end

  def destroy
    authorize @task
    @task.destroy
    redirect_to user_tasks_path, notice: 'Задача удалена.'
  end

  private

  def task_params
    params.require(:task).permit(:name, :description, :state, :file, :user_id)
  end

  def get_task
    @task = Task.find(params[:id])
  end
end
