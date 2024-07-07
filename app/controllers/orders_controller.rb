class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item, only: [:index, :new, :create, :show]
  before_action :redirect_if_sold_out_or_not_eligible, only: [:new, :create]

  def index
    if @item.user == current_user || @item.sold_out?
      redirect_to root_path
    else
      gon.public_key = ENV['PAYJP_PUBLIC_KEY']
      @order_address = OrderAddress.new
    end
  end

  def new
    @order_address = OrderAddress.new(item_id: params[:item_id])
    render :index
  end

  def create
    @order_address = OrderAddress.new(order_params.merge(user_id: current_user.id, item_id: params[:item_id]))
    if @order_address.valid?
      pay_item
      @order_address.save
      Item.find(params[:item_id]).update(sold_out: true)
      redirect_to root_path
    else
      gon.public_key = ENV['PAYJP_PUBLIC_KEY']
      render :index, status: :unprocessable_entity
    end
  end

  private

  def set_item
    @item = Item.find(params[:item_id])
  end

  def order_params
    params.require(:order_address).permit(:postal_code, :prefecture_id, :city, :address, :building, :phone_number,
                                          :token).merge(token: params[:token])
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @item.price, # 商品の値段
      card: order_params[:token], # カードトークン
      currency: 'jpy' # 通貨の種類（日本円）
    )
  end

  def redirect_if_sold_out_or_not_eligible
    return unless @item.sold_out? || @item.user == current_user

    redirect_to root_path
  end
end
