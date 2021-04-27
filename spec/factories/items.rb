FactoryBot.define do
  factory :item do
    item_name          { Faker::JapaneseMedia::OnePiece.character }
    item_description   { Faker::JapaneseMedia::OnePiece.character }
    item_category_id   { 2 }
    item_status_id     { 2 }
    delivery_charge_id { 2 }
    prefectures_id     { 2 }
    shipping_days_id   { 2 }
    selling_price      { 300 }

    association :user

    after(:build) do |item|
      item.images.attach(io: File.open('public/images/test_image.jpeg'), filename: 'test_image.jpeg')
    end
  end
end
