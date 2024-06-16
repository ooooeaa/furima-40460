FactoryBot.define do
  factory :item do
    name { '商品名' }
    explain { '商品の説明' }
    category_id { 2 }
    sales_status_id { 2 }
    shipping_fee_status_id { 2 }
    prefecture_id { 2 }
    scheduled_delivery_id { 2 }
    price { 12_345 }
    association :user

    after(:build) do |item|
      item.image.attach(io: File.open(Rails.root.join('spec/fixtures/test_image.jpg')), filename: 'test_image.jpg',
                        content_type: 'image/jpeg')
    end
  end
end
