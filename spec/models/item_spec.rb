require 'rails_helper'

RSpec.describe Item, type: :model do
  describe '#create' do
    before do
      @item = FactoryBot.build(:item)
    end

    describe '新規出品機能' do
      it '全て適切に入力すれば商品出品できること' do
        expect(@item).to be_valid
      end

      it '画像が空では出品できないこと' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end

      it '商品名が空では出品できないこと' do
        @item.item_name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Item name can't be blank")
      end

      it '商品の説明が空では出品できないこと' do
        @item.item_description = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Item description can't be blank")
      end

      it 'カテゴリーの情報がなければ出品できないこと(ActiveHashのid:の値が１だと出品できないということ)' do
        @item.item_category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Item category Select')
      end

      it '商品の状態についての情報がなければ出品できないこと(ActiveHashのid:の値が１だと出品できないということ)' do
        @item.item_status_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Item status Select')
      end

      it '配送料の負担についての情報がなければ出品できないこと(ActiveHashのid:の値が１だと出品できないということ)' do
        @item.delivery_charge_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Delivery charge Select')
      end

      it '発送元の地域についての情報がなければ出品できないこと(ActiveHashのid:の値が１だと出品できないということ)' do
        @item.prefectures_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Prefectures Select')
      end

      it '発送までの日数についての情報がなければ出品できないこと(ActiveHashのid:の値が１だと出品できないということ)' do
        @item.shipping_days_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Shipping days Select')
      end

      it '販売価格が空では出品できないこと' do
        @item.selling_price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Selling price can't be blank")
      end

      it '販売価格が¥299以下ではでは出品できないこと' do
        @item.selling_price = '299'
        @item.valid?
        expect(@item.errors.full_messages).to include('Selling price Out of setting range')
      end

      it '販売価格が¥10,000,000以上ではでは出品できないこと' do
        @item.selling_price = '10000000'
        @item.valid?
        expect(@item.errors.full_messages).to include('Selling price Out of setting range')
      end

      it '販売価格は全角数字では出品できないということ' do
        @item.selling_price = '３０００'
        @item.valid?
        expect(@item.errors.full_messages).to include('Selling price Half-width number')
      end
    end
  end
end
