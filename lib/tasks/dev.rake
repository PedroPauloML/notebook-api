namespace :dev do
  desc "Config develoment environment"
  task setup: :environment do
    puts %x(rails db:drop:_unsafe)
    puts %x(rails db:create)
    puts %x(rails db:migrate)
    puts %x(rails dev:generate_kinds)
    puts %x(rails dev:generate_contacts)
    puts %x(rails dev:generate_phones)
    puts %x(rails dev:generate_addresses)
  end

  desc "Generate kinds"
  task generate_kinds: :environment do
    puts "Generating contacts kinds..."
    kinds = ["Amigo", "Conhecido", "Trabalho", "Família"]

    kinds.each do |kind|
      Kind.create!(
        description: kind
      )
    end
    puts "Generating contacts kinds... [OK]"
  end

  desc "Generate fake contacts"
  task generate_contacts: :environment do
    puts "Generating fakes contacts..."
    100.times do
      Contact.create!(
        name:      Faker::Name.name,
        email:     Faker::Internet.email,
        birthdate: Faker::Date.between(65.years.ago, 18.years.ago),
        kind_id:   Kind.ids.sample
      )
    end
    puts "Generating fakes contacts... [OK]"
  end

  desc "Generate fake phones"
  task generate_phones: :environment do
    puts "Generating fakes phones..."
    Contact.all.each do |contact|
      Random.rand(5).times do |i|
        phone = Phone.new(number: Faker::PhoneNumber.cell_phone)
        contact.phones << phone
        contact.save!
      end
    end
    puts "Generating fakes phones... [OK]"
  end

  desc "Generate fake address"
  task generate_addresses: :environment do
    puts "Generating fakes address..."
    Contact.all.each do |contact|
      address = Address.create!(
        street:     Faker::Address.street_name,
        city:       Faker::Address.city,
        contact_id: contact.id
      )
    end
    puts "Generating fakes address... [OK]"
  end
end
