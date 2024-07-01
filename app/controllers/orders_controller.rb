class OrdersController < ApplicationController
  before_action :set_item, only: [:index, :new, :create, :show]

  def index
    @order_address = OrderAddress.new
  end

  def new
    @order_address = OrderAddress.new(item_id: params[:item_id])
  end

  def create
    @order_address = OrderAddress.new(order_params.merge(user_id: current_user.id, item_id: params[:item_id]))
    if @order_address.valid?
      @order_address.save
      redirect_to root_path
    else
      render :index, status: :unprocessable_entity
    end
  end

  private

  def set_item
    @item = Item.find(params[:item_id] || params[:id])
  end

  def order_params
    params.require(:order_address).permit(:user_id, :item_id, :postal_code, :prefecture_id, :city, :address, :building,
                                          :phone_number).merge(user_id: current_user.id)
  end
end
