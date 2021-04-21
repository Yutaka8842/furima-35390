class Item < ApplicationRecord
  with_options presence: true do
    validates :item_name
    validates :item_description
    validates :item_category_id
    validates :item_status_id
    validates :delivery_charge_id
    validates :prefectures_id
    validates :shipping_days_id
    validates :selling_price
  end
  belongs_to :user
end
