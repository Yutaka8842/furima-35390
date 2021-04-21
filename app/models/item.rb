class Item < ApplicationRecord

  belongs_to :user
  has_one_attached :image
  
  with_options presence: true do
    validates :image
    validates :item_name
    validates :item_description
    validates :item_category_id,   numericality: { other_than: 1 } 
    validates :item_status_id,     numericality: { other_than: 1 } 
    validates :delivery_charge_id, numericality: { other_than: 1 } 
    validates :prefectures_id,     numericality: { other_than: 1 } 
    validates :shipping_days_id,   numericality: { other_than: 1 } 
    validates :selling_price,      numericality: { greater_than: 299, less_than: 10000000} 
  end

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :item_category
  belongs_to :item_status
  belongs_to :delivery_charge
  belongs_to :prefectures
  belongs_to :shipping_days

end
