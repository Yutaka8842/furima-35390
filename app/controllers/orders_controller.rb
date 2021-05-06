class OrdersController < ApplicationController
  before_action :authenticate_user!, only: [:index, :create]
  before_action :params_id, only: [:index, :create]
  before_action :move_to_root, only: [:index, :create]
  before_action :sold_move_to_root, only: [:index, :create]

  def index
    @order_address = OrderAddress.new

    Payjp.api_key = ENV["PAYJP_SECRET_KEY"] # 環境変数を読み込む
    card = Card.find_by(user_id: current_user.id)
    customer = Payjp::Customer.retrieve(card.customer_token) # 先程のカード情報を元に、顧客情報を取得
    @card = customer.cards.first
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

      # if @order_address.valid?
       # pay_item
        # @order_address.save
        # redirect_to root_path
      # else
       # render 'index'
      # end
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

 # def pay_item
  #  Payjp.api_key = ENV['PAYJP_SECRET_KEY']
  #  Payjp::Charge.create(
  #    amount: @item.selling_price,
  #    card: order_params[:token],
  #    currency: 'jpy'
  #  )
 # end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"] # 環境変数を読み込む
    customer_token = current_user.card.customer_token # ログインしているユーザーの顧客トークンを定義
    Payjp::Charge.create(
      amount: @item.selling_price, # 商品の値段
      customer: customer_token, # 顧客のトークン
      currency: 'jpy' # 通貨の種類（日本円）
    )
  end
end
