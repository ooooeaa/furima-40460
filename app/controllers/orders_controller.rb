class OrdersController < ApplicationController
  def new
    @order_form = OrderForm.new
  end

  def create
    @order_form = OrderForm.new(order_form_params)
    if @order_form.save
      redirect_to root_path, notice: 'Order was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def order_form_params
    params.require(:order_form).permit(:user_id, :item_id, :postal_code, :city, :street, :country)
  end
end
