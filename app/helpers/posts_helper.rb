# -*- encoding : utf-8 -*-
module PostsHelper
  def show_post_body(post)
    h(post.body).gsub(/#(#{Tag::FORMAT})/i){|x| raw link_to h(x), show_tag_path(:name => x[1..-1])}.html_safe
  end
end
