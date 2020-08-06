# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

User.destroy_all
City.destroy_all
Gossip.destroy_all
Tag.destroy_all
Comment.destroy_all

# Création de 10 utilisateurs :
# -----------------------------
10.times do
  City.create!(name: Faker::Address.city, zip_code: Faker::Address.zip_code)
end

10.times do
  User.create!(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, description: Faker::Lorem.sentence, email: Faker::Internet.email, age: rand(15..80), city_id: City.all.sample.id)
end


20.times do |index| #cree 20 gossip en reference avec user
  Gossip.create!(title: "Gossip#{index+1}",content: Faker::ChuckNorris.fact, user: User.all.sample)
end

10.times do     #cree 10 tag
  Tag.create(title: "##{Faker::Games::Pokemon.name}")
end


10.times do
  PrivateMessage.create!(content: Faker::Lorem.sentence, sender_id: User.all.sample.id, recipient_id: User.all.sample.id)
end

20.times do
  TagGossip.create!(tag_id: Tag.all.sample.id, gossip_id: Gossip.all.sample.id)
end

# Créations de quelques commentaires de Gossips
Comment.create!(content: "bravo pour ton gossip !", user: User.first, gossip: Gossip.find_by(user: User.first))
Comment.create!(content: "c'est une belle journée", user: User.last, gossip: Gossip.find_by(user: User.last))

City.create!(name: "Paris", zip_code: "75014")

User.create!(first_name: "anonymous", last_name: Faker::Name.last_name, description: Faker::Lorem.sentence, email: Faker::Internet.email, age: rand(30..60), city: City.last)
Gossip.create!(title: "Pour une fois",content: Faker::ChuckNorris.fact, user: User.last)
Comment.create!(content: "Et avec du soleil", user: User.last, gossip: Gossip.find_by(user: User.last))
