# -*- encoding : utf-8 -*-
class User < ActiveRecord::Base
  authenticates_with_sorcery!
  ROLES=%w(Пользователь Модератор Администратор)
  validates :name, :presence => true, :length => {:maximum => 100}
  validates :email, :presence => true, :uniqueness => true, :format => {:with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i}
  validates :password, :presence => true, :confirmation => true, :length => {:minimum => 5}, :if => :password_present?
  validates :role, :presence => true, :inclusion => {:in => 0...ROLES.size}
  has_many :posts, :order => "post.created_at"
  has_attached_file :avatar, :styles => {:medium => "100x100>", :thumb => "20x20>"}

  def user?
    role==0
  end

  def moderator?
    role==1
  end

  def admin?
    role==2
  end

  def privilege?
    moderator? || admin?
  end

  def human_role
    ROLES[role.to_i]
  end

  def password_present?
    password.present?
  end

  def sex
    if (male==true)
      "мужской"
    elsif (male==false)
      "женский"
    else
      "не определен"
    end
  end

  def age
    return 0 if birthday.blank?
    now = Date.today
    year = now.year - birthday.year
    year -=  1 if (birthday+year.year) > now
    year
  end
end
