require 'rails_helper'

RSpec.describe OrderAddress, type: :model do
  describe '#create' do
    before do
      user = FactoryBot.create(:user)
      item = FactoryBot.create(:item)
      @order_address = FactoryBot.build(:order_address, user_id: user.id, item_id: item.id)
      sleep 0.1
    end

    describe '商品購入機能' do
      it '全て適切に入力すれば商品購入できること' do
          expect(@order_address).to be_valid
      end

      it 'user_idが空では商品購入できないこと' do
        @order_address.user_id = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("User can't be blank")
      end

      it 'item_idが空では商品購入できないこと' do
        @order_address.item_id = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Item can't be blank")
      end

      it 'トークンが空では商品購入できないこと' do
        @order_address.token = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Token can't be blank")
      end

      it '郵便番号が空では商品購入できないこと' do
        @order_address.postal_code = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Postal code can't be blank")
      end

      it '郵便番号が(３桁の数字)-(４桁の数字)でなければ商品購入できないこと' do
        @order_address.postal_code = 1000001
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Postal code Input correctly')
      end

      it '都道府県が空では商品購入できないこと（ActiveHashのidが１という事）' do
        @order_address.prefectures_id = 1
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Prefectures Select")
      end
      
      it '市区町村が空では商品購入ができないということ' do
        @order_address.municipality = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Municipality can't be blank")
      end

      it '番地が空では商品購入ができないということ' do
        @order_address.address_number = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Address number can't be blank")
      end

      it '建物名は空でも商品購入できること' do
        @order_address.building_name = ''
        expect(@order_address).to be_valid
      end

      it '電話番号が空では登録できないという事' do
        @order_address.phone_number = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Phone number can't be blank")
      end

      it '電話番号が12桁以上の数字だと商品購入はできないということ' do
        @order_address.phone_number = '111111111111'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Phone number Input only number')
      end
    end
  end
end
