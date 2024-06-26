class OrdersController < ApplicationController
  def index
    @orders = Order.includes(:item).all
    @items = Item.all
  end
  
  def new
    @order_address = OrderAddress.new
    @items = Item.all 
  end

  def create
    @order_address = OrderAddress.new(order_params)
    if @order_address.save
      redirect_to root_path, notice: '注文が完了しました。'
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def order_params
    params.require(:order_address).permit(:user_id, :item_id, :postal_code, :prefecture, :city, :address, :building, :phone_number)
  end
end
