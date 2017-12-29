namespace :db do

  desc "Fill database with sample data"
  
  task populate: :environment do
  
    admin = User.create!(name: "Example User",
                 email: "example@railstutorial.org",
                 password: "foobar",
                 password_confirmation: "foobar",
                 admin: true)
               
    zzy = User.create!(name: "Zzy",
                 email: "897224436@qq.com",
                 password: "zzy970625",
                 password_confirmation: "zzy970625")
                 
                 
    50.times do |n|
      name = Faker::Name.name
      email = "example-#{n+1}@railstutorial.org"
      password = "password"
      User.create!(name: name,
                   email: email,
                   password: password,
                   password_confirmation: password)
    end # 99.times
    
    
    #users = User.all(limit: 6)
    users = User.all
    50.times do
      content = Faker::Lorem.sentence(5)
      users.each { |user| user.microposts.create!(content: content) }
    end # 50.times
    
  end # task populate
  
  
  
  task make_table: :environment do
  
    50.times do |n|
      floor = Table.floor_range[rand(0..2)]
      zone = Table.zone_range[rand(0..3)]
      with_window = Table.with_window_range[0..1]
      with_charge = Table.with_charge_range[0..1]
      table = Table.create!(table_number: n,
                   floor: floor,
                   zone: zone,
                   with_window: with_window,
                   with_charge: with_charge)
    end # 50.times

  end # task make_table
  
  
  
  
  task make_seat: :environment do
    tables = Table.all
      
    tables.each do |table|
      4.times do |n|
        table.seats.create!(seat_number: 4*table.table_number+n)
      end
    end
  end # task make_seat
  
  
  
  task make_booking: :environment do
    seats = Seat.all
    
    seats.each do |seat|
      (Booking.time_range.last-Booking.time_range.first).times do |n|
        seat.bookings.create!(timestart: n+Booking.time_range.first,
                           timeend: n+Booking.time_range.first+1)
      end
    end
  end # tast make_booking
  
end
