class Item < ApplicationRecord

  belongs_to :user
  
  validates :name,                     presence: true
  validates :content,                  presence: true
  validates :category_id,              presence: true
  validates :condition_id,             presence: true
  validates :shipping_fee_burden_id,   presence: true
  validates :prefecture_id,            presence: true
  validates :days_until_shipping_id,   presence: true
  validates :selling_price,            presence: true
end
