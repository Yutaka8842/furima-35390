FactoryBot.define do
  factory :order_address do
    token          {'tok_abcdefghijk00000000000000000'}
    postal_code    { '100-0001' }
    prefectures_id { 2 }
    municipality   { Faker::Movies::HarryPotter.location }
    address_number { Faker::Movies::HarryPotter.character }
    building_name  { Faker::Movies::HarryPotter.house }
    phone_number   { 11111111111 }
  end
end
