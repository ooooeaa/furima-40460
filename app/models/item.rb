class Item < ApplicationRecord
  belongs_to :order
  belongs_to :user
  has_one_attached :image
  
  validates :name, presence: true
  validates :explain, presence: true
  #validates :category_id, presence: true
  validates :sales_status_id, presence: true
  validates :shipping_fee_status_id, presence: true
  validates :prefecture_id, presence: true
  validates :scheduled_delivery_id, presence: true
  validates :price, presence: true

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  #空の投稿を保存できないようにする
  validates :category_id, :text, presence: true

  #ジャンルの選択が「---」の時は保存できないようにする
  validates :category_id, numericality: { other_than: 1, message: "can't be blank" } 
  

end
