# -*- encoding : utf-8 -*-
class UsersController < ApplicationController
  before_filter :check_auth, :except => [:new, :create]
  before_filter :check_admin, :only => [:index]

  def index
    @users = User.order(:id).all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    @user.role= 0

    if @user.save
      redirect_to root_path, :notice => "success"
    else
      render 'new'
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.deleted_at = Time.now
    @user.save
    redirect_to users_path, :notice => "Пользователь удален"
  end

  def edit
    @user = current_user
  end

  def update_avatar
    @user = current_user
    @user.avatar = params[:user][:avatar]
    @user.save
    if @user.update_attributes(params[:user])
      flash[:notice] = "Аватар сохранен"
    else
      flash[:error] = "Аватар не сохранен"
    end
    render 'edit'
  end

  def update_sex
    @user = current_user
    @user.male = params[:user][:male]
    if @user.update_attributes(params[:user])
      flash[:notice] = "Пол изменен"
    else
      flash[:error] = "Пол не изменен"
    end
    render 'edit'
  end

  def update_sign
    @user = current_user
    @user.sign = params[:user][:sign]
    if @user.update_attributes(params[:user])
      flash[:notice] = "Подпись сохранена"
    else
      flash[:error] = "Подпись не сохранена"
    end
    render 'edit'
  end

  def update_birthday
    @user=current_user
    @user.birthday=params[:user][:birthday]
    if @user.update_attributes(params[:user])
      flash[:notice]="Дата рождения обновлена"
    else
      flash[:error] = "Дата рождения не обновлена"
    end
    render 'edit'
  end

  def update_password
    @user = current_user
    if login(@user.email, params[:user].delete(:old_password))
      if @user.update_attributes(params[:user])
        redirect_to profile_path, :notice => "Пароль изменен"
      else
        render 'edit'
      end
    else
      flash[:error] = "Введенный пароль не верен"
      render 'edit'
    end
  end
end
