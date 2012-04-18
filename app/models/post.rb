# -*- encoding : utf-8 -*-
class Post < ActiveRecord::Base
  belongs_to :user
  belongs_to :topic
  has_and_belongs_to_many :tags
  validates :body, :presence => true
  validates :user_id,:presence => true
  after_save :generate_tags

  def edit?(user)
    user && (user_id == user.id || user.privilege?)
  end

  def generate_tags
    str_tags = body.scan(/#(#{Tag::FORMAT})/i).flatten
    current_tags = Tag.where(:name => str_tags).all
    self.tags = current_tags
    (str_tags-current_tags.map(&:name)).each do |tag_name|
      t = Tag.create(:name => tag_name)
      self.tags << t
    end
    self.tags
  end
end
