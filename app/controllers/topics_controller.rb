# -*- encoding : utf-8 -*-
class TopicsController < ApplicationController
  before_filter :check_auth, :except => [:index, :show]
  before_filter :check_rank,  :only => [:edit, :update, :destroy]

  # GET /topics
  def index
    @topics = Topic.order("updated_at desc").all
  end

  # GET /topics/1
  def show
    @topic = Topic.find(params[:id])
    @posts = @topic.posts.includes(:user).page(params[:page]).per(10)
  end

  # GET /topics/new
  def new
    @topic = Topic.new
  end

  # GET /topics/1/edit
  def edit
    @topic = Topic.find(params[:id])
  end

  # POST /topics
  def create
    @topic = Topic.new(params[:topic])

    respond_to do |format|
      if @topic.save
        format.html { redirect_to @topic, notice: 'Тема успешно создана' }
      else
        format.html { render action: "new" }
      end
    end
  end

  # PUT /topics/1
  def update
    @topic = Topic.find(params[:id])
      respond_to do |format|
        if @topic.update_attributes(params[:topic])
          format.html { redirect_to topics_url, notice: 'Тема успешно обновлена' }
        else
          format.html { render action: "edit" }
        end
      end
  end

  # DELETE /topics/1
  def destroy
    @topic = Topic.find(params[:id])
    @topic.destroy

    respond_to do |format|
      format.html { redirect_to topics_url }
    end
  end

  private
  def check_rank
    @topic = Topic.find(params[:id])
    unless @topic.edit?(current_user)
      flash[:error] = "Недостаточно прав!"
      redirect_to topics
    end
  end
end
