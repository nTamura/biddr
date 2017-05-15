auctions = Auction.all
user = User.all

10.times do
  User.create(username: Faker::LordOfTheRings.character,
              email: Faker::Internet.safe_email,
              password: 'qweqwe',
              password_confirmation: 'qweqwe')
end
puts 'Created users!'

User.create(username: 'nTamura',
            email: 'nic@gmail.com',
            password: 'qweqwe',
            password_confirmation: 'qweqwe')
puts 'Created ntamura!'

User.create(username: 'Admin',
            email: 'admin@gmail.com',
            password: 'qweqwe',
            password_confirmation: 'qweqwe',
            is_admin: true)
puts 'Created Admin!'


# 30.times do
#   user.sample
#   Auction.create( title: Faker::Commerce.product_name,
#                   description:  Faker::Hipster.paragraph,
#                   reserve_price: rand(200),
#                   # user_id: user.id
#                   )
# end
# puts "Created auctions!"


# auctions.each do |a|
#   rand(1..4).times do
#     user.sample
#     a.Bid.create(price: rand(150),
#                   # user_id: user.id
#                   )
#   end
# end
# puts "Created bids!"

puts '>>> Seed complete <<<'
