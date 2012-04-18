# -*- encoding : utf-8 -*-
class ApplicationController < ActionController::Base
  protect_from_forgery
  private
  def check_auth
    unless logged_in?
      flash[:error]="Доступ без авторизации запрещен"
      redirect_to new_session_path
    end
  end

  def check_admin
    unless current_user.try(:admin?)
      flash[:error] = "Доступ запрещен!"
      redirect_to root_path
    end
  end
end
