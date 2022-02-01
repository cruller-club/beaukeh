# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

Beau.destroy_all

8888.times do |i|
  b = Beau.new
  b.make_a_beaukeh

  puts "#{'%05d' % i} #{b.signature}"

  b.save
end