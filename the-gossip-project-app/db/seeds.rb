require 'faker'
require 'colorize'

puts "Cleaning DB ...".colorize(:blue)
Like.destroy_all
Comment.destroy_all
JoinTableGossipTag.destroy_all
Tag.destroy_all
PrivateMessage.destroy_all
Gossip.destroy_all
User.destroy_all
City.destroy_all

puts "------------------------"
puts "Starting seeds ...".colorize(:light_green)

puts "------------------------"
puts "Creating Cities...".colorize(:light_blue)
cities = []
10.times do
  city = City.create(
    name: Faker::Address.city,
    zip_code: Faker::Address.zip_code
  )
  cities << city
end
puts "Cities created: #{City.count}".colorize(:light_green)

puts "------------------------"
puts "Creating Users...".colorize(:light_blue)
users = []
10.times do
  user = User.create(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    description: Faker::Lorem.sentence(word_count: 10),
    email: Faker::Internet.email,
    age: Faker::Number.between(from: 18, to: 80),
    city: cities.sample
  )
  users << user
end
puts "Users created: #{User.count}".colorize(:light_green)

puts "------------------------"
puts "Creating Gossips...".colorize(:light_blue)
gossips = []
20.times do
  title = nil
  loop do
    title = Faker::Lorem.word
    break if title.length.between?(3, 14)
  end

  gossip = Gossip.create!(
    title: title,
    content: Faker::Lorem.paragraph(sentence_count: 2),
    user: users.sample
  )
  gossips << gossip
end
puts "Gossips created: #{Gossip.count}".colorize(:light_green)

puts "------------------------"
puts "Creating Tags...".colorize(:light_blue)
tags = []
10.times do
  tag = Tag.create(title: "##{Faker::Hipster.word}")
  tags << tag
end
puts "Tags created: #{Tag.count}".colorize(:light_green)

puts "------------------------"
puts "Assigning tags to gossips...".colorize(:light_blue)
gossips.each do |gossip|
  JoinTableGossipTag.create(
    gossip: gossip,
    tag: tags.sample
  ) if gossip.persisted?
end
puts "Gossips-Tags properly linked !".colorize(:light_green)

puts "------------------------"
puts "Creating private messages...".colorize(:light_blue)
5.times do
  sender = User.all.sample
  recipients = User.all.reject{|u| u == sender}.sample(rand(1..3))
  message_content = Faker::Lorem.sentence(word_count: 5)
  recipients.each do |recipient|
    PrivateMessage.create(
      content: message_content,
      sender: sender,
      recipient: recipient
    )
  end
end
puts "PMs created: #{PrivateMessage.count}".colorize(:light_green)

puts "------------------------"
puts "Creating comments...".colorize(:light_blue)
20.times do
  Comment.create(
    content: Faker::Lorem.sentence,
    user: users.sample,
    commentable: gossips.sample # Polymorphism: linked to gossip ; gossips are commentable
  )
end
puts "Comments created: #{Comment.count}".colorize(:light_green)

puts "------------------------"
puts "Creating comments commenting other comments...".colorize(:light_blue)
10.times do
  parent_comment = Comment.all.sample
  if parent_comment # check if comment is not empty
    Comment.create(
      content: "Réponse : #{Faker::Lorem.sentence}",
      user: users.sample,
      commentable: parent_comment # Polymorphism : linked to comment ; comments are commentable
    )
  end
end
puts "10 Sub-comments created !".colorize(:light_green)

puts "------------------------"
puts "Generating many likes...".colorize(:light_blue)
20.times do
  likeable_object = [Gossip.all.sample, Comment.all.sample].sample #random like to gossips/comments
  Like.create(
    user: users.sample,
    likeable: likeable_object # Gossip ou Comment are likeable
  )
end
puts "#{Like.count} likes generated !".colorize(:light_green)
puts "------------------------"
puts "--- Seeds done ! ---".colorize(:light_green)