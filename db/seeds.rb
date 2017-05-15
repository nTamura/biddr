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


30.times do
  user = User.all.sample
  Auction.create( title: Faker::Commerce.product_name,
                  description:  Faker::Hipster.paragraph,
                  reserve_price: rand(200),
                  end_date: DateTime.now + (rand * 60),
                  user_id: user.id
                  )
end
puts "Created auctions!"

Auction.all.each do |auction|
  rand(5).times do
    user = User.all.sample
    auction.bids.create(price: rand(100).to_f,
                        user_id: user.id
    )
  end
end
puts "Bids created!"
puts '>>> Seed complete <<<'
