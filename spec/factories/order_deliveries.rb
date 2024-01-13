FactoryBot.define do
  factory :order_delivery do
    post_code               { '123-1234' }
    prefecture_id           { Faker::Number.between(from: 1, to: 47) }
    municipalities          { '千代田' }
    street_address          { '1-1' }
    building_name           { '皇居' }
    telephone_num           { '12345671234' }
    token                   { 'tok_abcdefghijk00000000000000000' }
  end
end
