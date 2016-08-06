# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create(username: "Jessica", password: "password123")
User.create(username: "Richie", password: "password123")

Sub.create(
  [
    { title: "Windows", description: "All about windows! Not the Microsoft OS", moderator_id: 1 },
    { title: "Doors", description: "In or out?", moderator_id: 2 },
    { title: "PARTYYYY", description: "Party hard man", moderator_id: 1}
  ]
)

Post.create(
  [
    { title: "In, man", content: "In is way better", url: "http://inandout.com", author_id: 2, sub_ids: [2] },
    { title: "Whooooooo doors", content: "I like when they swing", author_id: 1, sub_ids: [2, 3] }
  ]
)
