class Item < ApplicationRecord
  belongs_to :user
  has_one :order, dependent: :destroy
  has_one_attached :image, dependent: :destroy

  with_options presence: true do
    validates :image
    validates :item_name
    validates :item_description
    validates :selling_price, numericality: { greater_than: 299, less_than: 10_000_000, message: 'Out of setting range' }
    with_options numericality: { other_than: 1, message: 'Select' } do
      validates :item_category_id
      validates :item_status_id
      validates :delivery_charge_id
      validates :prefectures_id
      validates :shipping_days_id
    end
  end

  validates :selling_price, numericality: { only_integer: true, message: 'Half-width number' }

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :item_category
  belongs_to :item_status
  belongs_to :delivery_charge
  belongs_to :prefectures
  belongs_to :shipping_days
end
