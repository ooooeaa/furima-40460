class ItemsController < ApplicationController
  def index
    @items = Item.order("created_at DESC")
  end

  def new
    @items = Item.all
  end

  def create
    Item.create(Item_params)
    redirect_to '/'
  end

  private
  def item_params
    params.require(:item).permit(:name, :explain, :category_id, :sales_status_id, :shipping_fee_status_id, :prefecture_id, :scheduled_delivery_id,:price, :image).merge(user_id: current_user.id)
  end

end
