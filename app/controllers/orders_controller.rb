class OrdersController < ApplicationController
  def index
    @orders = Order.includes(:item).all
    specific_id = params[:item_id] 
    @item = Item.find_by(id: specific_id) 

  end
  
  def new
    @order_address = OrderAddress.new
    @item = Item.find(params[:item_id])
  end

  def create
    @order_address = OrderAddress.new(order_params)
    if @order_address.save
      redirect_to root_path, notice: '注文が完了しました。'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @item = Item.find(params[:id])
  end

  private

  def order_params
    params.require(:order_address).permit(:user_id, :item_id, :postal_code, :prefecture, :city, :address, :building, :phone_number).merge(user_id: current_user.id)
  end
end
