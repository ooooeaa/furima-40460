class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_item, only: [:destroy, :show, :edit, :update]
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
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  # def show
  # @item = Item.find(params[:id])
  # @user = @item.user
  # end

  # def destroy
  # @item.destroy
  # redirect_to items_path
  # end

  # def edit
  # @item = Item.find(params[:id])
  # end

  # def update
  # @item = Item.find(params[:id])
  # if @item.update(item_params)
  # redirect_to item_path(@item.id)
  # else
  # render :edit, status: :unprocessable_entity
  # end
  # end

  private

  def item_params
    params.require(:item).permit(:name, :explain, :category_id, :sales_status_id, :shipping_fee_status_id, :prefecture_id,
                                 :scheduled_delivery_id, :price, :image).merge(user_id: current_user.id)
  end

  # def set_item
  # @item = Item.find(params[:id])
  # end
end
