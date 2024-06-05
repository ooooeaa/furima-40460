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
      expect(@user.errors.full_messages).to include("Last_name can't be blank")
    end
    it 'first_nameが空では登録できない' do
      @user.first_name = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("First_name can't be blank")
    end
    it 'last_name_kanaが空では登録できない' do
      @user.last_name_kana = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Last_name_kana can't be blank")
    end
    it 'first_name_kanaが空では登録できない' do
      @user.first_name_kana = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("First_name_kana can't be blank")
    end
    it 'birth_dateが空では登録できない' do
      @user.birth_date = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Birth_date can't be blank")
    end
    it 'passwordは、６文字以上での入力が必須' do
      user_with_short_password = User.new(password: '12345')
      expect(user_with_short_password.valid?).to be(false)
    end
    it 'パスワードは半角英数字混合での入力が必須であること' do
      @user.birth_date = 'Password1'
      @user.valid?
      expect(@user.errors.full_messages).to include("パスワードは半角英数字混合での入力が必須")
    end
    it 'パスワードが半角英文字のみでは無効であること' do
      @user.birth_date = 'password'
      @user.valid?
      expect(user.errors[:password]).to include('は半角英数字混合での入力が必要です')
    end
    it 'パスワードが半角数字のみでは無効であること' do
      user = User.new(password: '12345678')
      user.valid?
      expect(user.errors[:password]).to include('は半角英数字混合での入力が必要です')
    end
    it 'passwordとpassword_confirmationは、値の一定が必要' do
      user = User.new(password: 'password123', password_confirmation: 'password456')
      expect(user.valid?).to be(false)
    end
    it 'last_nameとfirst_nameは、それぞれ全角（漢字・ひらがな・カタカナ）での入力が必須である' do
      user = User.new(last_name: 'yamada', first_name: 'tarou')
      expect(user).not_to be_valid
      expect(user.errors[:last_name]).to be_present
      expect(user.errors[:first_name]).to be_present
    end
    it 'last_name_kanaとfirst_name_kanaそれぞれが空では登録できない' do
      user = User.new(last_name_kana: '', first_name_kana: '')
      expect(user.valid?).to be(false)
    end
    it 'last_name_kanaとfirst_name_kanaは、全角（カタカナ）での入力が必須である' do
      user = User.new(last_name_kana: 'やまだ', first_name_kana: 'たろう')
      expect(user).not_to be_valid
      expect(user.errors[:last_name_kana]).to be_present
      expect(user.errors[:first_name_kana]).to be_present
    end
  end
end