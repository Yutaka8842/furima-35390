class Address < ApplicationRecord
  # with_options presence: true do
  #  validates :postal_code
  #  validates :prefectures_id, numericality: { other_than: 1, message: 'Select' } 
  #  validates :municipality
  #  validates :address_number
  #  validates :phone_number
  # end

  belongs_to :order
end
