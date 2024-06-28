class OrdersController < ApplicationController
  before_action :set_item, only: [:index, :new, :create, :show]

  def new
    @order_address = OrderAddress.new
  end

  def create
    @order = Order.new(user_id: order_params[:user_id], item_id: order_params[:item_id])
    if @order.save
      @address = Address.new(address_params.merge(order_id: @order.id))
      if @address.save
        redirect_to root_path, notice: '注文が完了しました。'
      else
        @order.destroy
        render :new, status: :unprocessable_entity
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_item
    @item = Item.find(params[:item_id] || params[:id])
  end

  def order_params
    params.require(:order_address).permit(:user_id, :item_id)
  end

  def address_params
    params.require(:order_address).permit(:user_id, :item_id, :postal_code, :prefecture_id, :city, :address, :building, :phone_number)
  end
end
