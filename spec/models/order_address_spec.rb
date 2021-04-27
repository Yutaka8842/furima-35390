require 'rails_helper'

RSpec.describe OrderAddress, type: :model do
  describe '#create' do
    before do
      user = FactoryBot.create(:user)
      item = FactoryBot.create(:item)
      @order_address = FactoryBot.build(:order_address, user_id: user.id, item_id: item.id)
      sleep 0.1
    end

    context '商品が購入できる場合' do
      it '全て適切に入力すれば商品購入できること' do
          expect(@order_address).to be_valid
      end

      it '建物名は空でも商品購入できること' do
        @order_address.building_name = ''
        expect(@order_address).to be_valid
      end
    end

    context '商品が購入できない場合' do
      it 'user_idが空では商品購入できないこと' do
        @order_address.user_id = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('ログインをしてくださいを入力してください')
      end

      it 'item_idが空では商品購入できないこと' do
        @order_address.item_id = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('商品を選んでくださいを入力してください')
      end

      it 'トークンが空では商品購入できないこと' do
        @order_address.token = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('クレジットカード情報を入力してください')
      end

      it '郵便番号が空では商品購入できないこと' do
        @order_address.postal_code = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('郵便番号を入力してください')
      end

      it '郵便番号が(３桁の数字)-(４桁の数字)でなければ商品購入できないこと' do
        @order_address.postal_code = 1000001
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('郵便番号正しく入力してください')
      end

      it '都道府県が空では商品購入できないこと（ActiveHashのidが１という事）' do
        @order_address.prefectures_id = 1
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('都道府県を選んでください')
      end
      
      it '市区町村が空では商品購入ができないということ' do
        @order_address.municipality = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('市区町村を入力してください')
      end

      it '番地が空では商品購入ができないということ' do
        @order_address.address_number = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('番地を入力してください')
      end

      it '電話番号が空では登録できないという事' do
        @order_address.phone_number = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('電話番号を入力してください')
      end

      it '電話番号が12桁以上の数字だと商品購入はできないということ' do
        @order_address.phone_number = '111111111111'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('電話番号1~11桁半角数字で入力してください')
      end

      it '電話番号が英数字混合では登録できないこと' do
        @order_address.phone_number = 'aaaaa111111'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('電話番号1~11桁半角数字で入力してください')
      end
    end
  end
end
