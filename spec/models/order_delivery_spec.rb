require 'rails_helper'

RSpec.describe OrderDelivery, type: :model do
  describe '商品購入' do
    before :all do
      @user = FactoryBot.create(:user)
      @item = FactoryBot.create(:item)
    end

    before do
      @order_delivery = FactoryBot.build(:order_delivery, user_id: @user.id, item_id: @item.id)
    end

    context '内容に問題ない場合' do
      it 'すべての値が正しく入力されていれば保存できること' do
        expect(@order_delivery).to be_valid
      end
      it 'building_nameは空でも保存できること' do
        @order_delivery.building_name = ''
        expect(@order_delivery).to be_valid
      end
    end
    context '内容に問題ある場合' do
      it 'post_codeが空だと保存できない' do
        @order_delivery.post_code = ''
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("Post code can't be blank")
      end
      it 'prefecture_idが0だと保存できない' do
        @order_delivery.prefecture_id = 0
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("Prefecture can't be blank")
      end
      it 'municipalitiesが空だと保存できない' do
        @order_delivery.municipalities = ''
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("Municipalities can't be blank")
      end
      it 'street_addressが空だと保存できない' do
        @order_delivery.street_address = ''
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("Street address can't be blank")
      end
      it 'telephone_numが空だと保存できない' do
        @order_delivery.telephone_num = ''
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("Telephone num can't be blank")
      end
      it 'user_idが空(userが紐づいてない)だと保存できない' do
        @order_delivery.user_id = ''
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("User can't be blank")
      end
      it 'item_idが空(itemが紐づいてない)だと保存できない' do
        @order_delivery.item_id = ''
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("Item can't be blank")
      end
      it 'post_codeが半角数字3桁-半角数字4桁でないと保存できない' do
        @order_delivery.post_code = '12341234'
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include('Post code is invalid. Enter it as follows (e.g. 123-4567)')
      end
      it 'telephone_numが半角数字でないと保存できない' do
        @order_delivery.telephone_num = '１１１１１１１１１１１'
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include('Telephone num is invalid. Input only number')
      end
      it 'telephone_numが10より小さいと保存できない' do
        @order_delivery.telephone_num = '123456789'
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include('Telephone num is too short (minimum is 10 characters)')
      end
      it 'telephone_numが11より大さいと保存できない' do
        @order_delivery.telephone_num = '123456789012'
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include('Telephone num is too long (maximum is 11 characters)')
      end
      it 'tokenが空では登録できない' do
        @order_delivery.token = ''
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("Token can't be blank")
      end
    end
  end
end
