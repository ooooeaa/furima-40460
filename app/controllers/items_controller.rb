class ItemsController < ApplicationController
  def index
    @items = Item.order("created_at DESC")
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      logger.debug(@item.errors.full_messages)
      # or if you prefer using byebug:
      # byebug
      render :new
    end
  end
  

  private
  def item_params
    params.require(:item).permit(:name, :explain, :category_id, :sales_status_id, :shipping_fee_status_id, :prefecture_id, :scheduled_delivery_id,:price, :image).merge(user_id: current_user.id)
  end

end
