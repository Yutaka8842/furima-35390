class Item < ApplicationRecord
  belongs_to :user
  has_one :order, dependent: :destroy
  has_many_attached :images, dependent: :destroy

  has_many :item_tags
  has_many :tags, through: :item_tags

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :item_category
  belongs_to :item_status
  belongs_to :delivery_charge
  belongs_to :prefectures
  belongs_to :shipping_days
end
