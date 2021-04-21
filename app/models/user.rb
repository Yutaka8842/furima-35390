class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i.freeze
  FULL_WIDTH = /\A[ぁ-んァ-ン一-龥]+\z/.freeze
  KATAKANA = /\A[ァ-ヶー－]+\z/.freeze

  validates_format_of :password, with: PASSWORD_REGEX, message: 'Include both letters and numbers'
  validates :nickname, presence: true
  validates :first_name, presence: true, format: { with: FULL_WIDTH, message: 'Full-width characters' }
  validates :last_name, presence: true, format: { with: FULL_WIDTH, message: 'Full-width characters' }
  validates :first_name_kana, presence: true, format: { with: KATAKANA, message: 'Full-width katakana characters' }
  validates :last_name_kana, presence: true, format: { with: KATAKANA, message: 'Full-width katakana characters' }
  validates :birthday, presence: true
end
