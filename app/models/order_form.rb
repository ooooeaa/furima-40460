class OrderForm
  include ActiveModel::Model

  # 手順1-3. `attr_accessor` を用いて、保存したい複数のテーブルのカラム名すべてを扱えるようにする
  attr_accessor :user_id, :item_id, :postal_code, :city, :street, :country

  # 手順1-4. バリデーションの処理を書く
  validates :user_id, :item_id, :postal_code, :city, :street, :country, presence: true

  # 手順1-5. データをテーブルに保存する処理を書く
  def save
    return false unless valid?

    ActiveRecord::Base.transaction do
      order = Order.create!(user_id: user_id, item_id: item_id)
      Address.create!(order_id: order.id, postal_code: postal_code, city: city, street: street, country: country)
    end
    true
  rescue ActiveRecord::RecordInvalid
    false
  end
end
