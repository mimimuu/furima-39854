FactoryBot.define do
  factory :user do
    nickname              { 'test' }
    email                 { Faker::Internet.free_email }
    password              { 'test1111' }
    password_confirmation { password }
    first_name            { '陸' }
    last_name             { '山田' }
    first_name_kana       { 'リク' }
    last_name_kana        { 'ヤマダ' }
    birthday              { '1970-01-01' }
  end
end
