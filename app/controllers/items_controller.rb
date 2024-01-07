class ItemsController < ApplicationController
  def index
  end
  def new
    @item = Item.new
  end

  def create
    @item = Item.new(items_params)
    if @item.valid?
      @item.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end

  end

  private

  def items_params
    params.require(:item).permit(:name,:content,:category_id,:condition_id,:shipping_fee_burden_id,:prefecture_id,:days_until_shipping_id,:selling_price).merge(user_id: current_user.id)
  end

end
