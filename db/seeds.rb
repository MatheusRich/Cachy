# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

50.times { Author.find_or_create_by(name: Faker::Name.unique.name) }
50.times { Book.find_or_create_by(title: Faker::Book.title, author_id: Author.ids.sample) }