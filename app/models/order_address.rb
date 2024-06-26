lass OrderAddress
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :postal_code, :prefecture, :city, :address, :building, :phone_number

  validates :user_id, :item_id, :city, :address, :building, :phone_number, presence: true
  validates :postal_code, presence: true, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)" }
  validates :prefecture, numericality: { other_than: 0, message: "can't be blank" }

  def save
    return false unless valid?

    ActiveRecord::Base.transaction do
      order = Order.create!(user_id: user_id, item_id: item_id)
      Address.create!(order_id: order.id, postal_code: postal_code, prefecture_id: prefecture, city: city, addresses: address, building: building, phone_number: phone_number)
    end
    true
  rescue ActiveRecord::RecordInvalid
    false
  end

  belongs_to :item
end
