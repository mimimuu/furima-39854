class OrderDelivery
  include ActiveModel::Model
  attr_accessor :post_code,:prefecture,:municipalities,:street_address,:building_name,:telephone_num,:user_id,:item_id

  with_options presence: true do
    validates :post_code
    validates :municipalities
    validates :street_address
    validates :building_name
    validates :telephone_num
    validates :user_id
    validates :item_id
  end
  validates :prefecture, numericality: { other_than: 0, message: "can't be blank"}

  def save
    order = Order.create(user_id: user_id, item_id: item_id)
    Delivery.create(post_code: post_code,prefecture: prefecture,municipalities: municipalities,street_address: street_address,building_name: building_name,telephone_num: telephone_num, order_id: order.id)
  end
  
end