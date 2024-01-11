class OrdersController < ApplicationController
  def index
    gon.public_key = ENV['PAYJP_PUBLIC_KEY']
    @item = Item.find(params[:item_id])
    if user_signed_in? && current_user.id != @item.user_id
      @orderdelivery = OrderDelivery.new
    else
      redirect_to root_path
    end
  end

  def create
    @orderdelivery = OrderDelivery.new(order_delivery)
    if @orderdelivery.valid?
      pay_item
      @orderdelivery.save
      redirect_to root_path
    else
      gon.public_key = ENV['PAYJP_PUBLIC_KEY']
      @item = Item.find(params[:item_id])
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
end
