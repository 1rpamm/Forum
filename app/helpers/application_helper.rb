# -*- encoding : utf-8 -*-
module ApplicationHelper
  def show_flash
    res=[]
    flash.each do |k, v|
      res << content_tag(:div, v, :class => "flash_#{k}")
    end
    raw(res.join)
  end
end
