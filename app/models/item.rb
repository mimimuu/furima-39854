class Item < ApplicationRecord

  belongs_to :user

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :shipping_fee_burden
  belongs_to :prefecture
  belongs_to :days_until_shipping

  validates :name,                     presence: true
  validates :content,                  presence: true
  validates :category_id,              presence: true, numericality: { other_than: 1, message: "can't be blank"}
  validates :condition_id,             presence: true, numericality: { other_than: 1, message: "can't be blank"}
  validates :shipping_fee_burden_id,   presence: true, numericality: { other_than: 1, message: "can't be blank"}
  validates :prefecture_id,            presence: true, numericality: { other_than: 0, message: "can't be blank"}
  validates :days_until_shipping_id,   presence: true, numericality: { other_than: 1, message: "can't be blank"}
  validates :selling_price,            presence: true

end
