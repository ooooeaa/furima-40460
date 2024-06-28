class OrderAddress
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :postal_code, :prefecture_id, :city, :address, :building, :phone_number

  validates :city, presence: true
  validates :address, presence: true
  validates :phone_number, presence: true
  validates :postal_code, presence: true, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)" }
  validates :prefecture_id, numericality: { other_than: 0, message: "can't be blank" }

  def save
    order = Order.create(user_id: user_id, item_id: item_id)
    Address.create(
      order_id: order_id, 
      postal_code: postal_code, 
      prefecture_id: prefecture_id, 
      city: city, 
      address: address, 
      building: building, 
      phone_number: phone_number
    )
    true
  end
end

