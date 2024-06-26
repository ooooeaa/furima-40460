class ItemsController < ApplicationController
  before_action :set_item, only: [:destroy, :show, :edit, :update]
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :redirect_if_not_authorized, only: [:edit, :update, :destroy]
  skip_before_action :authenticate_user!, only: [:index]

  def index
    @items = Item.order('created_at DESC')
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      Order.create(order_params)
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @item = Item.find(params[:id])
    @user = @item.user
  end

  def destroy
    @item.destroy
    redirect_to root_path
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to item_path(@item.id)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # def sold?
  #   !buyer.nil?
  # end

  private

  def item_params
    params.require(:item).permit(:name, :explain, :category_id, :sales_status_id, :shipping_fee_status_id, :prefecture_id,
                                 :scheduled_delivery_id, :price, :image).merge(user_id: current_user.id)
  end
  def order_params
    params.permit(:postal_code, :prefecture, :city, :addresses, :building, :phone_number).merge(item_id: @item.id)
  end
  def set_item
    @item = Item.find(params[:id])
  end

  def redirect_if_not_authorized
    return unless current_user.id != @item.user_id

    redirect_to root_path
  end
end
