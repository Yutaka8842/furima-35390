class Item < ApplicationRecord

  belongs_to :user
  has_one_attached :image
  
  with_options presence: true do
    validates :image
    validates :item_name
    validates :item_description
    validates :item_category_id,   numericality: { other_than: 1, message: 'Select' }
    validates :item_status_id,     numericality: { other_than: 1, message: 'Select' }
    validates :delivery_charge_id, numericality: { other_than: 1, message: 'Select' }
    validates :prefectures_id,     numericality: { other_than: 1, message: 'Select' }
    validates :shipping_days_id,   numericality: { other_than: 1, message: 'Select' }
    validates :selling_price,      numericality: { greater_than: 299, less_than: 10000000, message: 'Out of setting range' }
  end
    validates :selling_price,      numericality: { only_integer: true, message: 'Half-width number' }

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :item_category
  belongs_to :item_status
  belongs_to :delivery_charge
  belongs_to :prefectures
  belongs_to :shipping_days

end
