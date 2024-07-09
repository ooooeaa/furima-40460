class OrderAddress
  include ActiveModel::Model
  # DonationAddressクラス内でattr_accessorを使用します。
  # donationsテーブルとaddressesテーブルに保存したいカラム名を、すべて指定してください。
  attr_accessor :user_id, :item_id, :postal_code, :prefecture_id, :city, :address, :building, :phone_number, :token

  with_options presence: true do
    validates :user_id
    validates :item_id
    validates :city
    validates :address
    validates :phone_number, format: { with: /\A\d{10,11}\z/, message: 'is invalid' }
    validates :postal_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'is invalid. Include hyphen(-)' }
    validates :token
    validates :prefecture_id, numericality: { other_than: 1, message: "can't be blank" }
  end

  def save
    # Orderテーブルにデータを保存
    order = Order.create(user_id:, item_id:)

    # Addressテーブルにデータを保存
    Address.create(
      order_id: order.id,
      postal_code:,
      prefecture_id:,
      city:,
      address:,
      building:,
      phone_number:
    )
  end
end
