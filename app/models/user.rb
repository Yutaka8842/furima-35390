class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i.freeze
  FULL_WIDTH = /\A[ぁ-んァ-ヶ一-龥々ー]+\z/.freeze
  KATAKANA = /\A[ァ-ヶー－]+\z/.freeze

  validates_format_of :password, with: PASSWORD_REGEX, message: 'Include both letters and numbers'
  
  with_options presence: true do
    validates :nickname
    validates :first_name, format: { with: FULL_WIDTH, message: 'Full-width characters' }
    validates :last_name, format: { with: FULL_WIDTH, message: 'Full-width characters' }
    validates :first_name_kana, format: { with: KATAKANA, message: 'Full-width katakana characters' }
    validates :last_name_kana, format: { with: KATAKANA, message: 'Full-width katakana characters' }
    validates :birthday
  end

  has_many :items
end
