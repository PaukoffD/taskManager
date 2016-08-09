class SessionsController < ApplicationController
  layout 'signin'

  def new
  end

  def create
    user = User.find_by_email(params[:sessions][:email])
    if user && user.authenticate(params[:sessions][:password])
      session[:user_id] = user.id
      redirect_to user_tasks_path(user), notice: 'Вы вошли в систему.'
    else
      flash[:alert] = 'Неверные почта или пароль'
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: 'Вы вышли из системы.'
  end
end
