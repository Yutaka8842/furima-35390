FactoryBot.define do
  factory :user do
    gimei = Gimei.name
    nickname              { Faker::Name.name }
    email                 { Faker::Internet.free_email }
    password              { 'aaa111' } # Fakerだと英字のみや数字のみが生成されてしまう事がある為手打ち
    password_confirmation { password }
    last_name             { gimei.last.kanji }
    first_name            { gimei.first.kanji }
    last_name_kana        { gimei.last.katakana }
    first_name_kana       { gimei.first.katakana }
    birthday              { Faker::Date.backward }
  end
end
