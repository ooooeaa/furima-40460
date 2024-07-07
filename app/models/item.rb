class Item < ApplicationRecord
  has_one :order
  belongs_to :user
  has_one_attached :image

  validates :image, presence: true
  validates :name, presence: true
  validates :explain, presence: true
  validates :price, presence: { message: "can't be blank" }
  validates :price, numericality: { only_integer: true, message: 'is not a number' }, allow_nil: true
  validates :price, numericality: { only_integer: true, greater_than_or_equal_to: 300, message: 'must be greater than or equal to 300' },
                    allow_nil: true
  validates :price, numericality: { only_integer: true, less_than_or_equal_to: 9_999_999, message: 'must be less than or equal to 9999999' },
                    allow_nil: true
  def sold_out?
    sold_out
  end

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  validates :category_id, presence: true, numericality: { other_than: 1, message: "can't be blank" }

  belongs_to :sales_status
  validates :sales_status_id, presence: true, numericality: { other_than: 1, message: "can't be blank" }

  belongs_to :shipping_fee_status
  validates :shipping_fee_status_id, presence: true, numericality: { other_than: 1, message: "can't be blank" }

  belongs_to :prefecture
  validates :prefecture_id, presence: true, numericality: { other_than: 1, message: "can't be blank" }

  belongs_to :scheduled_delivery
  validates :scheduled_delivery_id, presence: true, numericality: { other_than: 1, message: "can't be blank" }
end
