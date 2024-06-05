require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    it 'nicknameが空では登録できない' do
      @user.nickname = ''
      @user.valid?
      expect(@user.errors.full_messages).to include "Nickname can't be blank"
    end
    it 'emailが空では登録できない' do
      @user.email = ''
      @user.valid?
      expect(@user.errors.full_messages).to include "Email can't be blank"
    end
    it 'passwordが空では登録できない' do
      @user.password = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Password can't be blank")
    end
    it 'last_nameが空では登録できない' do
      @user.last_name = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name can't be blank")
    end
    it 'first_nameが空では登録できない' do
      @user.first_name = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("First name can't be blank")
    end
    it 'last_name_kanaが空では登録できない' do
      @user.last_name_kana = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name kana can't be blank")
    end
    it 'first_name_kanaが空では登録できない' do
      @user.first_name_kana = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("First name kana can't be blank")
    end
    it 'birth_dateが空では登録できない' do
      @user.birth_date = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Birth date can't be blank")
    end
    it 'passwordは、６文字以上での入力が必須' do
      @user.password = '12345'
      @user.valid?
      expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
    end
    it 'パスワードは半角英数字混合での入力が必須であること' do
      @user.password = 'Password1'
      @user.valid?
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end
    it 'パスワードが半角英文字のみでは無効であること' do
      @user.password = 'password'
      @user.valid?
      expect(@user.errors[:password]).to include("must contain both letters and numbers")
    end
    it 'パスワードが半角数字のみでは無効であること' do
      @user.password = '12345678'
      @user.valid?
      expect(@user.errors[:password]).to include("must contain both letters and numbers")
    end
    it 'passwordとpassword_confirmationは、値の一定が必要' do
      @user.password = 'password123'
      @user.password_confirmation = 'password456'
      expect(@user.valid?).to be(false)
    end
    it 'last_nameとfirst_nameは、それぞれ全角（漢字・ひらがな・カタカナ）での入力が必須である' do
      @user.last_name = 'yamada'
      @user.first_name = 'tarou'
      expect(@user).not_to be_valid
      expect(@user.errors[:last_name]).to be_present
      expect(@user.errors[:first_name]).to be_present
    end
    it 'last_name_kanaとfirst_name_kanaは、全角（カタカナ）での入力が必須である' do
      @user.last_name_kana = 'やまだ'
      @user.first_name_kana = 'たろう'
      expect(@user).not_to be_valid
      expect(@user.errors[:last_name_kana]).to be_present
      expect(@user.errors[:first_name_kana]).to be_present
    end
  end
end