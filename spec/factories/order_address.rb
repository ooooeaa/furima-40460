FactoryBot.define do
  factory :order_address do
    # address
    postal_code { '111-1111' }
    prefecture_id { 2 }
    city { '東京都渋谷区' }
    address { '渋谷1-2-3' }
    phone_number { '09012345678' }
    # price {3000}
    token { 'tok_abcdefghijk00000000000000000' }
  end
end
