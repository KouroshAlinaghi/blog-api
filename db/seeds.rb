# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
for author_id in [1,5,6,8] 
  5.times do
    params = {
      author_id: author_id,
      title: Faker::Name.name,
      body: Faker::Lorem.paragraph(sentence_count: 4) 
    }
    Post.create(params)
  end
end
