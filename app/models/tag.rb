# -*- encoding : utf-8 -*-
class Tag < ActiveRecord::Base
  FORMAT='[\wа-яё\+\-]+'
  has_and_belongs_to_many :posts
  validates :name, :presence => true, :uniqueness => true, :format => {:with => /^#{FORMAT}$/i}
end
