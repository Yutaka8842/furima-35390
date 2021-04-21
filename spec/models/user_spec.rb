require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#create' do
    before do
      @user = FactoryBot.build(:user)
      # Fakerを使うとpasswordが英字のみor数字のみが生成されてしまう事がある為passwordのみ手打ち password { aaa111 }
    end



    describe 'ユーザー新規登録' do
      it '全て適切に入力すれば新規登録できること' do
        expect(@user).to be_valid
      end

      it 'ニックネームが空では登録できないこと' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end

      it 'メールアドレスが空では登録できないこと' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end

      it 'メールアドレスが一意性であること' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end

      it 'パスワードが空では登録できないこと' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end

      it 'パスワードが半角英数字がそれぞれ入っていれば登録可能なこと' do
        @user.password = 'aaaaa1'
        @user.password_confirmation = @user.password
        expect(@user).to be_valid
      end

      it 'パスワードが半角数字だけでは登録できないこと' do
        @user.password = '111111'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password Include both letters and numbers')
      end

      it 'パスワードが半角英字だけでは登録できないこと' do
        @user.password = 'aaaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password Include both letters and numbers')
      end

      it 'パスワードが５文字以下では登録ができないこと' do
        @user.password = 'aaa11'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end

      it 'パスワードとパスワード確認用と一致していないと登録ができないこと' do
        @user.password = 'aaa111'
        @user.password_confirmation = 'bbb111'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end

      it 'お名前（全角）は名字が空では登録できないこと' do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name can't be blank")
      end

      it 'お名前（全角）は名前が空では登録できないこと' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank")
      end

      it 'お名前（全角）は名字がひらがなで登録できること(FactoryBotでは漢字の為)' do
        @user.last_name = 'あああ'
        expect(@user).to be_valid
      end

      it 'お名前（全角）は名前がひらがなで登録できること(FactoryBotでは漢字の為)' do
        @user.first_name = 'あああ'
        expect(@user).to be_valid
      end

      it 'お名前（全角）は名字がカタカナで登録できること(FactoryBotでは漢字の為)' do
        @user.last_name = 'アアア'
        expect(@user).to be_valid
      end

      it 'お名前（全角）は名前がカタカナで登録できること(FactoryBotでは漢字の為)' do
        @user.first_name = 'アアア'
        expect(@user).to be_valid
      end

      it 'お名前（全角）は名字が（漢字・ひらがな・カタカナ）以外では登録できないこと' do
        @user.last_name = 'aaa'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name Full-width characters')
      end

      it 'お名前（全角）は名前が（漢字・ひらがな・カタカナ）以外では登録できないこと' do
        @user.first_name = 'aaa'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name Full-width characters')
      end

      it 'お名前カナ（全角）は名字が空では登録できないこと' do
        @user.last_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana can't be blank")
      end

      it 'お名前カナ（全角）は名前が空では登録できないこと' do
        @user.first_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana can't be blank")
      end

      it 'お名前カナ（全角）は名字がカタカナ以外では登録できないこと' do
        @user.last_name_kana = 'あああ'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name kana Full-width katakana characters')
      end

      it 'お名前カナ（全角）は名前がカタカナ以外では登録できないこと' do
        @user.first_name_kana = 'あああ'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name kana Full-width katakana characters')
      end

      it '生年月日が空では登録できないこと' do
        @user.birthday = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Birthday can't be blank")
      end
    end
  end
end
