# -*- encoding : utf-8 -*-
class PostsController < ApplicationController
  # GET /posts
  before_filter :check_auth
  before_filter :load_topic
  before_filter :check_rank,  :only => [:edit, :update, :destroy]

  def index
    @posts = Post.all
  end

  # GET /posts/1
  def show
    @post = Post.find(params[:id])
  end

  # GET /posts/new
  def new
    @post = @topic.posts.build
  end

  # GET /posts/1/edit
  def edit
    @post = @topic.posts.find(params[:id])
  end

  # POST /posts
  def create
    @post = @topic.posts.new(params[:post])
    @post.user_id = current_user.id
    if @post.save
      redirect_to @topic, notice:'Сообщение создано'
    else
      render 'new'
    end
  end

  # PUT /posts/1
  def update
    @post = @topic.posts.find(params[:id])
   if @post.update_attributes(params[:post])
       redirect_to @topic, :notice => "Сообщение обновлено"
    else
      render 'edit'
   end

  end

  # DELETE /posts/1
  def destroy
    @post = @topic.posts.find(params[:id])
    @post.destroy
      redirect_to @topic, :notice => "Сообщение удалено"
  end

  private
  def load_topic
    @topic=Topic.find(params[:topic_id])
  end

  def check_rank
    @post = @topic.posts.find(params[:id])
    if !@post.edit?(current_user)
      redirect_to @topic, :notice => "Недостаточно прав!"
    end
  end

end
