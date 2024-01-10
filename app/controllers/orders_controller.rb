class OrdersController < ApplicationController

  def index
    @item = Item.find(params[:item_id])
    @orderdelivery = OrderDelivery.new
  end

  def create
    @orderdelivery = OrderDelivery.new(order_delivery)
    if @orderdelivery.valid?
      @orderdelivery.save
      redirect_to root_path
    else
      @item = Item.find(params[:item_id])
      render :index, status: :unprocessable_entity
    end
  end

  private
  def order_delivery
    params.require(:order_delivery).permit(:post_code,:prefecture_id, :municipalities, :street_address, :building_name, :telephone_num).merge(user_id: current_user.id, item_id: params[:item_id])
  end

end
