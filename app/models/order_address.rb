class OrderAddress
  include ActiveModel::Model
  attr_accessor :postal_code, :prefectures_id, :municipality, :address_number, :building_name, :phone_number, :order_id, :user_id, :item_id, :token

  POSTAL_CODE = /\A\d{3}[-]\d{4}\z/.freeze
  PHONE_NUMBER = /\A\d{1,11}\z/.freeze

  with_options presence: true do
    validates :postal_code,    format: { with: POSTAL_CODE, message: '正しく入力してください' }
    validates :prefectures_id, numericality: { other_than: 1, message: 'を選んでください' }
    validates :municipality
    validates :address_number
    validates :phone_number,   format: { with: PHONE_NUMBER, message: '1~11桁半角数字で入力してください' }
    validates :user_id
    validates :item_id
    validates :token
  end

  def save
    order = Order.create(user_id: user_id, item_id: item_id)
    Address.create(postal_code: postal_code, prefectures_id: prefectures_id, municipality: municipality, address_number: address_number, building_name: building_name, phone_number: phone_number, order_id: order.id)
  end
end
