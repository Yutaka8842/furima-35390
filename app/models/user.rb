class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i.freeze
  FULL_WIDTH = /\A[ぁ-んァ-ヶ一-龥々ー]+\z/.freeze
  KATAKANA = /\A[ァ-ヶー－]+\z/.freeze

  validates_format_of :password, with: PASSWORD_REGEX, message: 'は半角英字・半角数字を含めて入力してください'
  with_options presence: true do
    validates :nickname
    validates :first_name, format: { with: FULL_WIDTH, message: 'は全角（ひらがな・カタカナ・漢字）で入力してください' }
    validates :last_name, format: { with: FULL_WIDTH, message: 'は全角（ひらがな・カタカナ・漢字）で入力してください' }
    validates :first_name_kana, format: { with: KATAKANA, message: 'は全角（カタカナ）で入力してください' }
    validates :last_name_kana, format: { with: KATAKANA, message: 'は全角（カタカナ）で入力してください' }
    validates :birthday
  end
  has_many :orders
  has_many :items
  has_one :card, dependent: :destroy
end
