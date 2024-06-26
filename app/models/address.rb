class Address
  belongs_to :order

   # 数字3桁、ハイフン、数字4桁の並びのみ許可する
   #validates :postal_code, presence: true, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)"}
   # 0以外の整数を許可する
   #validates :prefecture, numericality: {other_than: 0, message: "can't be blank"}
 

  # 手順1-4. バリデーションの処理を書く
  #validates :user_id, :item_id, :postal_code, :prefecture, :city, :address, :building, :phone_number, presence: true

  # 手順1-5. データをテーブルに保存する処理を書く
  
end
