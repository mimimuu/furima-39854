class OrdersController < ApplicationController
  before_action :authenticate_user!, only: [:index]
  before_action :payjp_pass, only: [:index]

  def index
    return redirect_to root_path unless user_signed_in? && current_user.id != @item.user_id && @item.order.nil?

    @orderdelivery = OrderDelivery.new
  end

  def create
    @orderdelivery = OrderDelivery.new(order_delivery)
    if @orderdelivery.valid?
      pay_item
      @orderdelivery.save
      redirect_to root_path
    else
      payjp_pass
      render :index, status: :unprocessable_entity
    end
  end

  private

  def order_delivery
    params.require(:order_delivery).permit(:post_code, :prefecture_id, :municipalities, :street_address, :building_name, :telephone_num).merge(
      user_id: current_user.id, item_id: params[:item_id], token: params[:token]
    )
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    item = Item.find(params[:item_id])
    Payjp::Charge.create(
      amount: item.selling_price,
      card: order_delivery[:token],
      currency: 'jpy'
    )
  end

  def payjp_pass
    gon.public_key = ENV['PAYJP_PUBLIC_KEY']
    @item = Item.find(params[:item_id])
  end
end
