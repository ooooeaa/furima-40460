require 'rails_helper'

RSpec.describe OrderAddress, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.create(:item, user: @user)
    @order_address = FactoryBot.build(:order_address, user_id: @user.id, item_id: @item.id)
  end

  describe '商品購入' do
    context '商品購入ができる時' do
      it 'user_idが存在する' do
        @order_address.user_id = 1
        expect(@order_address).to be_valid
      end
      it 'item_idが存在する' do
        @order_address.item_id = 1
        expect(@order_address).to be_valid
      end
    end

    context '商品購入ができない時' do
      it 'user_idが空では登録できない' do
        @order_address.user_id = nil
        @order_address.valid?
        expect(@order_address.errors[:user_id]).to include('must exist')
      end
      it 'item_idが空では登録できない' do
        @order_address.item_id = nil
        @order_address.valid?
        expect(@order_address.errors[:item_id]).to include('must exist')
      end
    end
  end

  describe '配送先情報' do
    context '配送先情報が登録できる時' do
      it 'postal_codeが存在する' do
        @order_address.postal_code = '123-4567'
        expect(@order_address).to be_valid
      end
      it 'prefectureが存在する' do
        @order_address.prefecture_id = 1
        expect(@order_address).to be_valid
      end
      it 'cityが存在する' do
        @order_address.city = 'Tokyo'
        expect(@order_address).to be_valid
      end
      it 'addressが存在する' do
        @order_address.address = 'Shibuya'
        expect(@order_address).to be_valid
      end
      it 'phone_numberが存在する' do
        @order_address.phone_number = '09012345678'
        expect(@order_address).to be_valid
      end
    end

    context '配送先情報が登録できない時' do
      it 'postal_codeが空では登録できない' do
        @order_address.postal_code = nil
        @order_address.valid?
        expect(@order_address.errors[:postal_code]).to include("can't be blank")
      end
      it 'postal_codeは3桁-4桁の半角文字列でないと登録できない' do
        @order_address.postal_code = '1234'
        @order_address.valid?
        expect(@order_address.errors[:postal_code]).to include('is invalid. Include hyphen(-)')
      end
      it 'prefectureが空では登録できない' do
        @order_address.prefecture_id = nil
        @order_address.valid?
        expect(@order_address.errors[:prefecture_id]).to include("can't be blank")
      end
      it 'cityが空では登録できない' do
        @order_address.city = nil
        @order_address.valid?
        expect(@order_address.errors[:city]).to include("can't be blank")
      end
      it 'addressが空では登録できない' do
        @order_address.address = nil
        @order_address.valid?
        expect(@order_address.errors[:address]).to include("can't be blank")
      end
      it 'phone_numberが空では登録できない' do
        @order_address.phone_number = nil
        @order_address.valid?
        expect(@order_address.errors[:phone_number]).to include("can't be blank")
      end
      it 'phone_numberが10桁以上11桁以内の半角数値でないと登録できない' do
        @order_address.phone_number = '123456789'
        @order_address.valid?
        expect(@order_address.errors[:phone_number]).to include('is invalid')
      end
    end
  end
end
