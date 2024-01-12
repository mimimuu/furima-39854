class OrderDelivery
  include ActiveModel::Model
  attr_accessor :post_code, :prefecture_id, :municipalities, :street_address, :building_name, :telephone_num, :user_id, :item_id,
                :token

  with_options presence: true do
    validates :post_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'is invalid. Enter it as follows (e.g. 123-4567)' }
    validates :municipalities
    validates :street_address
    validates :telephone_num, numericality: { only_integer: true, message: 'is invalid. Input only number' },
                              length: { in: 10..11 }
    validates :user_id
    validates :item_id
    validates :token
  end
  validates :prefecture_id, numericality: { other_than: 0, message: "can't be blank" }

  def save
    order = Order.create(user_id:, item_id:)
    Delivery.create(post_code:, prefecture_id:, municipalities:,
                    street_address:, building_name:, telephone_num:, order_id: order.id)
  end
end
