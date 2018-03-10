# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Movie.create(title: 'Blade Runner', body: 'Freaking beast boy', rating: 'PG-13', director: 'Gandalf', release_date: 'March 21st, 2018', image: File.open("#{Rails.root}/spec/fixtures/files/blade_runner.jpeg"))
