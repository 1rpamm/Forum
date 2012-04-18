#encoding: utf-8
namespace :posts do
  desc "создание 10 постов для каждого топика"
  task :create => :environment do
    topics = Topic.all
    topics.each_with_index do |topic, i|
      3.times do |j|
        user = User.order("random()").limit(1).first
        post = Post.new(:topic => topic, :user => user, :body => "Like it! <br> #commit_1")
        unless post.save
          puts "Произошли ошибки"
          post.errors.full_messages.each_with_index do |msg, k|
            puts "#{k+1}. #{msg}"
          end
        end
      end
    end
  end
end