#encoding: utf-8
namespace :users do
  desc "make 10 users"
  task :create => :environment do
    o = [('a'..'z'),('A'..'Z')].map{|i| i.to_a}.flatten
    from = 0.0
    to = Time.now
    user = User.new(:name => "Admin", :email => "admin@qq.com", :password => "qwerty",
                    :password_confirmation => "qwerty", :role => 2, :male => 1,
                    :birthday => Time.at(from + rand * (to.to_f - from.to_f)) )
    user.save
    20.times do |j|
      user = User.new(:name => "#{(0..10).map{o[rand(o.length)]}.join}",
                      :email => "#{(0..8).map{o[rand(o.length)]}.join}@#{(0..3).map{o[rand(o.length)]}.join}.com",
                      :password => "qwerty", :password_confirmation => "qwerty", :role => rand(2), :male => rand(2),
                      :birthday => Time.at(from + rand * (to.to_f - from.to_f)) )
      unless user.save
        puts "Произошли ошибки"
      end
    end
  end
end