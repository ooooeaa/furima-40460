FactoryBot.define do
  factory :order do
    user_id { 1 }
    item_id { 1 }
    status { "MyString" }
  end
end
