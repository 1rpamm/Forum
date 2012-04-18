# -*- encoding : utf-8 -*-
class SessionsController < ApplicationController
  def new
  end

  def create
    @user=login(params[:email], params[:password])
    if @user
      redirect_to root_path, :notice => "Вы вошли как #{@user.name}"
    else
      flash[:error]="Неверный email или пароль"
      render 'new'
    end
  end

  def destroy
    logout
    redirect_to new_session_path, :notice => "Выход выполнен"
  end
end
