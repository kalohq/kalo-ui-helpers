require "faker"

FactoryBot.define do
  factory :user do
    id { Faker::Number.number(6) }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.email }
    address_line1 { "#{Faker::Address.building_number} #{Faker::Address.street_name}" }
    address_line2 { Faker::Address.street_name }
    city { Faker::Address.city }
    country_code { Faker::Address.country_code }
    state_province { Faker::Address.state }
    postal_code { Faker::Address.postcode }
  end

  trait :long_name do
    first_name { "ReallyReallyReallyLonglongName" }
  end
end
