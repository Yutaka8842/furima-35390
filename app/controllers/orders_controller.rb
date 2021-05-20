class OrdersController < ApplicationController
  before_action :authenticate_user!, only: [:index, :create]
  before_action :params_id, only: [:index, :create]
  before_action :move_to_root, only: [:index, :create]
  before_action :sold_move_to_root, only: [:index, :create]

  def index
    if current_user.card.blank?
      redirect_to new_card_path
    else
    @order_address = OrderAddress.new
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    card = Card.find_by(user_id: current_user.id)
    customer = Payjp::Customer.retrieve(card.customer_token)
    @card = customer.cards.first
    end
  end

  def create
    redirect_to new_card_path and return unless current_user.card.present?
    @order_address = OrderAddress.new(order_params)
    if @order_address.valid?
      pay_item
      @order_address.save
      redirect_to root_path
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
    if current_user.id == @item.user.id
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
    customer_token = current_user.card.customer_token 
    Payjp::Charge.create(
      amount: @item.selling_price,
      customer: customer_token, 
      currency: 'jpy' 
    )
  end
end
