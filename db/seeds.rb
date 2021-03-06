# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

5.times do
  Book.create({
    title: Faker::Book.title,
    author: "Stephen King",
    publisher: Faker::Book.publisher,
    genre: Faker::Book.genre,
    description: Faker::Lorem.sentence(word_count: 5),
    release_date: Faker::Date.in_date_period,
    edition: Faker::Number.number(digits: 1)
  })
end

5.times do
  Book.create({
    title: Faker::Book.title,
    author: Faker::Book.author,
    publisher: "Dark Horse",
    genre: Faker::Book.genre,
    description: Faker::Lorem.sentence(word_count: 5),
    release_date: Faker::Date.in_date_period,
    edition: Faker::Number.number(digits: 1)
  })
end

10.times do
  Book.create({
    title: Faker::Book.title,
    author: Faker::Book.author,
    publisher: Faker::Book.publisher,
    genre: Faker::Book.genre,
    description: Faker::Lorem.sentence(word_count: 5),
    release_date: Faker::Date.in_date_period,
    edition: Faker::Number.number(digits: 1)
  })
end

