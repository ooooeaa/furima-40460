require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'ユーザー新規登録' do
    it 'nicknameが空では登録できない' do
      user = User.new(nickname: '', email: 'test@example', password: '000000', password_confirmation: '000000')
      user.valid?
      expect(user.errors.full_messages).to include("Nickname can't be blank")
    end
    it 'emailが空では登録できない' do
      user = User.new(nickname: 'test', email: '', password: '000000', password_confirmation: '000000')
      user.valid?
      expect(user.errors.full_messages).to include("Email can't be blank")
    end
    it 'passwordが空では登録できない' do
      user = User.new(nickname: 'test', email: 'test@example', password: '', password_confirmation: '000000')
      user.valid?
      expect(user.errors.full_messages).to include("Password can't be blank")
    end
    it 'passwordは、６文字以上での入力が必須' do
      user_with_short_password = User.new(password: '12345')
      expect(user_with_short_password.valid?).to be(false)
    end
    it 'passwordは、半角英数字混合での入力が必須' do
      user = User.new(password: '123456', password_confirmation: '123456')
      user.valid?
      expect(user.errors[:password]).to include("は半角6文字以上となり、英字と数字の両方を含む必要があります")
    end
    it 'passwordとpassword_confirmationは、値の一定が必要' do
      user = User.new(password: 'password123', password_confirmation: 'password456')
      expect(user.valid?).to be(false)
    end
    it 'last_nameとfirst_nameそれぞれが空では登録できない' do
      user = User.new(last_name: '', first_name: '')
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
    it 'birth_dateが空では登録できない' do
      user = User.new(birth_date: nil)
      expect(user.valid?).to be(false)
    end
  end
end