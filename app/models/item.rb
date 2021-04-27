class Item < ApplicationRecord
  belongs_to :user
  has_one :order, dependent: :destroy
  has_many_attached :images, dependent: :destroy

  with_options presence: true do
    validates :images
    validates :item_name
    validates :item_description
    validates :selling_price, numericality: { greater_than: 299, less_than: 10_000_000, message: 'を¥300~¥9,999,999の間で入力してください' }
    with_options numericality: { other_than: 1, message: 'を選んでください' } do
      validates :item_category_id
      validates :item_status_id
      validates :delivery_charge_id
      validates :prefectures_id
      validates :shipping_days_id
    end
  end

  validates :selling_price, numericality: { only_integer: true, message: '半角数字で入力してください' }

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :item_category
  belongs_to :item_status
  belongs_to :delivery_charge
  belongs_to :prefectures
  belongs_to :shipping_days
end
