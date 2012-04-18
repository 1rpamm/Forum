class TagsController < ApplicationController
  def index
    @tags = Tag.includes(:posts).all.sort_by{|x| -x.posts.size}
  end

  def show
    @tag = Tag.includes(:posts => :user).where(:name=>params[:name]).first
  end
end
