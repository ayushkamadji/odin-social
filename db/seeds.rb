# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
20.times do |i|
  u = User.create(email: "user-#{i}@example.org", password: "123456", password_confirmation: "123456")
  u.reload
  u.create_profile(first_name: "user-#{i}", last_name: "example", avatar_url: "")

  10.times do |j|
    u.posts.create(content: "Post##{j}: This is post number #{j} by #{u.profile.first_name}. This is a test post, so it is supposed to be dull and weird.")
  end

  u.reload
  u.comments.create(post_id: u.posts.first.id, content: "This is the test comment by user-#{i}")
end

20.times do |i|
  Friendship.create(first_user_id: 3, second_user_id: User.find_by(email: "user-#{i}@example.org").id)
end
