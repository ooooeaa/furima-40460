class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname, presence: true
  VALID_PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i
  validates :password, presence: true, format: { with: VALID_PASSWORD_REGEX, message: 'は半角6文字以上となり、英字と数字の両方を含む必要があります' }
  validates :first_name, :last_name, presence: true, format: { with: /\A[ぁ-んァ-ン一-龠々]+\z/, message: "は全角で入力してください。" }
  validates :first_name_kana, :last_name_kana, presence: true, format: { with: /\A[\p{katakana}\p{blank}ー－]+\z/,message: "は全角カタカナで入力してください" }
  validates :birth_date, presence: true

  has_many :items
end
