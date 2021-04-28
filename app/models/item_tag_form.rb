class ItemTagForm

  include ActiveModel::Model
  attr_accessor :name, :images, :item_name, :item_description, :selling_price, :item_category_id, :item_status_id, :delivery_charge_id, :prefectures_id, :shipping_days_id, :user_id

  with_options presence: true do
    validates :name
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

  def save
    item = Item.create(images: images, item_name: item_name, item_description: item_description, selling_price: selling_price, item_category_id: item_category_id, item_status_id: item_status_id, delivery_charge_id: delivery_charge_id, prefectures_id: prefectures_id, shipping_days_id: shipping_days_id, user_id: user_id)
    tag = Tag.where(name: name).first_or_initialize
    tag.save

    ItemTag.create(item_id: item.id, tag_id: tag.id)
  end

end