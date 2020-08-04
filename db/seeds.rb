# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


Idea.delete_all
User.delete_all
Review.delete_all

NUM_IDEAS = 20
NUM_USERS = 10
PASSWORD = 'supersecret'

NUM_USERS.times do 
    first_name = Faker::Name.first_name
    last_name = Faker::Name.last_name

    User.create(
        first_name: first_name,
        last_name: last_name,
        email: "#{first_name.downcase}.#{last_name.downcase}@example.com",
        password: PASSWORD
    )
end

users = User.all

NUM_IDEAS.times do 
    created_at = Faker::Date.backward(days: 365)
    i = Idea.create(
        title: Faker::Game.title,
        body: Faker::Games::Dota.quote,
        created_at: created_at, 
        updated_at: created_at,
        user: users.sample
    )

    if i.valid?
        i.reviews = rand(0..15).times.map do 
            Review.new(
                body: Faker::Quotes::Shakespeare.as_you_like_it_quote,
                user: users.sample
            )
        end
    end
end

idea = Idea.all
review = Review.all

puts Cowsay.say("Generated #{users.count} users", :frogs)
puts Cowsay.say("Generated #{idea.count} ideas", :tux)
puts Cowsay.say("Generated #{review.count} reviews for ideas", :bunny)


