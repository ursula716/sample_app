namespace :db do
  desc "Fill database with sample data"
  #how the task will be described when you run "rake -T"
  task populate: :environment do    #makes a task that is runnable by "rake db:populate"
    User.create!(name: "Example User", email: "example@railstutorial.org", password: "foobar", password_confirmation: "foobar", admin: true)
    #creates a user so that you can actually sign in
    99.times do |n|
      name  = Faker::Name.name
      email = "example-#{n+1}@railstutorial.org"  #example-2@railstutorial.org and so on
      password  = "password"
      User.create!(name: name, email: email, password: password, password_confirmation: password)
    end
    
    users = User.all(limit: 6)
    50.times do
      content = Faker::Lorem.sentence(5)
      users.each { |user| user.microposts.create!(content: content) }
    end
  end
end