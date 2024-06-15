require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.build(:item, user: @user)
  end

  describe '商品出品' do
    context '新規商品出品できるとき' do
      it 'imageが存在する' do
        @item.image = fixture_file_upload('spec/fixtures/test_image.jpg')
        expect(@item).to be_valid
      end
      it 'nameが40文字以内で存在する' do
        @item.name = '商品名'
        expect(@item).to be_valid
      end
      it 'explainが1000文字以内で存在する' do
        @item.explain = '商品です'
        expect(@item).to be_valid
      end
      it 'categoryが存在する' do
        @item.category_id = 2
        expect(@item).to be_valid
      end
      it 'sales_statusが存在する' do
        @item.sales_status_id = 2
        expect(@item).to be_valid
      end
      it 'shipping_fee_statusが存在する' do
        @item.shipping_fee_status_id = 2
        expect(@item).to be_valid
      end
      it 'prefectureが存在する' do
        @item.prefecture_id = 2
        expect(@item).to be_valid
      end
      it 'scheduled_deliveryが存在する' do
        @item.prefecture_id = 2
        expect(@item).to be_valid
      end
      it 'priceが半角数字、300〜9,999,999の範囲内で存在する' do
        @item.price = 12_345
        expect(@item).to be_valid
      end
    end
    context '新規商品出品できないとき' do
      it 'nameが空では登録できない' do
        @item.name = nil
        @item.valid?
        expect(@item.errors[:name]).to include("can't be blank")
      end
      it 'imageが空では登録できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors[:image]).to include("can't be blank")
      end
      it 'explainが空では登録できない' do
        @item.explain = nil
        @item.valid?
        expect(@item.errors[:explain]).to include("can't be blank")
      end
      it 'categoryが未選択（1）では登録できない' do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors[:category_id]).to include("can't be blank")
      end
      it 'sales_statusが未選択（1）では登録できない' do
        @item.sales_status_id = 1
        @item.valid?
        expect(@item.errors[:sales_status_id]).to include("can't be blank")
      end
      it 'shipping_fee_statusが未選択（1）では登録できない' do
        @item.shipping_fee_status_id = 1
        @item.valid?
        expect(@item.errors[:shipping_fee_status_id]).to include("can't be blank")
      end
      it 'prefectureが未選択（1）では登録できない' do
        @item.prefecture_id = 1
        @item.valid?
        expect(@item.errors[:prefecture_id]).to include("can't be blank")
      end
      it 'scheduled_deliveryが未選択（1）では登録できない' do
        @item.scheduled_delivery_id = 1
        @item.valid?
        expect(@item.errors[:scheduled_delivery_id]).to include("can't be blank")
      end
      it 'priceが空では登録できない' do
        @item.price = nil
        @item.valid?
        expect(@item.errors[:price]).to include("can't be blank")
      end
      it 'priceは全角だと登録できない' do
        @item.price = '１２３４５'
        @item.valid?
        expect(@item.errors[:price]).to include('is not a number')
      end
      it 'priceは文字だと登録できない' do
        @item.price = 'abcd'
        @item.valid?
        expect(@item.errors[:price]).to include('is not a number')
      end
      it 'priceが300未満では登録できない' do
        @item.price = 299
        @item.valid?
        expect(@item.errors[:price]).to include('must be greater than or equal to 300')
      end
      it 'priceが10,000,000以上では登録できない' do
        @item.price = 10_000_000
        @item.valid?
        expect(@item.errors[:price]).to include('must be less than or equal to 9999999')
      end
    end
  end
end
