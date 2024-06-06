class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname, presence: true
  VALID_PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i
  validates :password, presence: true, format: { with: VALID_PASSWORD_REGEX, message: 'must contain both letters and numbers' }
  validates :first_name, :last_name, presence: true, format: { with: /\A[ぁ-んァ-ン一-龠々]+\z/ }
  validates :first_name_kana, :last_name_kana, presence: true, format: { with: /\A[\p{katakana}\p{blank}ー－]+\z/ }
  validates :birth_date, presence: true

  has_many :items
end
