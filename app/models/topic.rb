# -*- encoding : utf-8 -*-
class Topic < ActiveRecord::Base
  has_many :posts, :order => 'posts.created_at', :dependent => :destroy
  validates :name, :presence => true, :length => {:maximum => 140}
  validates :description, :length => {:maximum => 1500, :minimum => 6}, :allow_blank => true

  def edit?(user)
  user && user.privilege?
  end
end
