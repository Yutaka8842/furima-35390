class OrdersController < ApplicationController
  before_action :authenticate_user!, only: :index
  before_action :params_id, only: [:index, :create]  
  before_action :move_to_root, only: :index
  before_action :sold_move_to_root, only: :index


  def index
    @order_address = OrderAddress.new
  end

  def create
    @order_address = OrderAddress.new(order_params)
    if @order_address.valid?
      pay_item
      @order_address.save
      return redirect_to root_path
    else
      render 'index'
    end
  end

  private

  def order_params
    params.require(:order_address).permit(:postal_code, :prefectures_id, :municipality, :address_number, :building_name, :phone_number).merge(item_id: params[:item_id], user_id: current_user[:id], token: params[:token])
  end

  def params_id
    @item = Item.find(params[:item_id])
  end


  def move_to_root
    @item = Item.find(params[:item_id])
    if user_signed_in? && current_user.id == @item.user.id
      redirect_to root_path
    end
  end

  def sold_move_to_root
    if @item.order.present?
      redirect_to root_path
    end
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
      amount: @item.selling_price,
      card: order_params[:token],
      currency: 'jpy'
    )
  end
end
