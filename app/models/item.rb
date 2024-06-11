class Item < ApplicationRecord
  belongs_to :order
  belongs_to :user
  has_one_attached :image
  
  validates :name, presence: true
  validates :explain, presence: true
  #validates :category_id, presence: true
  #validates :sales_status_id, presence: true
  #validates :shipping_fee_status_id, presence: true
  #validates :prefecture_id, presence: true
  #validates :scheduled_delivery_id, presence: true
  validates :price, presence: true

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  validates :category_id, :text, presence: true
  validates :category_id, numericality: { other_than: 1, message: "can't be blank" } 
  
  belongs_to :sales_status
  validates :sales_status_id, :text, presence: true
  validates :sales_status_id, numericality: { other_than: 1, message: "can't be blank" } 

  belongs_to :shipping_fee_status
  validates :shipping_fee_status_id, :text, presence: true
  validates :shipping_fee_status_id, numericality: { other_than: 1, message: "can't be blank" } 

  belongs_to :prefecture
  validates :prefecture_id, :text, presence: true
  validates :prefecture_id, numericality: { other_than: 1, message: "can't be blank" } 

  belongs_to :scheduled_delivery
  validates :scheduled_delivery_id, :text, presence: true
  validates :scheduled_delivery_id, numericality: { other_than: 1, message: "can't be blank" } 

end
