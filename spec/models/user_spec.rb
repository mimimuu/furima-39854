require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end
  describe 'ユーザー管理機能' do
    context '新規登録できるとき' do
      it 'nickname/email/password/password_confirmation/first_name/last_name/first_name_kana/last_name_kana/birthdayが正しく存在すれば登録できる' do
        expect(@user).to be_valid
      end
    end
    context '新規登録できないとき' do
      context 'ユーザー情報' do
        it 'nicknameが空では登録できない' do
          @user.nickname = ''
          @user.valid?
          expect(@user.errors.full_messages).to include("Nickname can't be blank")
        end
        it 'emailが空では登録できない' do
          @user.email = ''
          @user.valid?
          expect(@user.errors.full_messages).to include("Email can't be blank")
        end
        it '重複したemailが存在する場合は登録できない' do
          @user.save
          another_user = FactoryBot.build(:user)
          another_user.email = @user.email
          another_user.valid?
          expect(another_user.errors.full_messages).to include('Email has already been taken')
        end
        it 'emailは@を含まないと登録できない' do
          @user.email = 'aaa'
          @user.valid?
          expect(@user.errors.full_messages).to include('Email is invalid')
        end
        it 'passwordが空では登録できない' do
          @user.password = ''
          @user.valid?
          expect(@user.errors.full_messages).to include("Password can't be blank")
        end
        it 'passwordが5文字以下では登録できない' do
          @user.password = 'test0'
          @user.password_confirmation = 'test0'
          @user.valid?
          expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
        end
        it 'passwordは英字のみのパスワードでは登録できない' do
          @user.password = 'testtest'
          @user.password_confirmation = 'testtest'
          @user.valid?
          expect(@user.errors.full_messages).to include('Password is invalid. Input half-width alphanumeric characters.')
        end
        it 'passwordは数字のみのパスワードでは登録できない' do
          @user.password = '111111'
          @user.password_confirmation = '111111'
          @user.valid?
          expect(@user.errors.full_messages).to include('Password is invalid. Input half-width alphanumeric characters.')
        end
        it 'passwordは全角文字を含むパスワードでは登録できない' do
          @user.password = 'test0あ'
          @user.password_confirmation = 'test0あ'
          @user.valid?
          expect(@user.errors.full_messages).to include('Password is invalid. Input half-width alphanumeric characters.')
        end
        it 'passwordとpassword_confirmationが不一致では登録できない' do
          @user.password = 't123456'
          @user.password_confirmation = 't1234567'
          @user.valid?
          expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
        end
      end
      context '本人情報確認' do
        it 'first_nameが空では登録できない' do
          @user.first_name = ''
          @user.valid?
          expect(@user.errors.full_messages).to include("First name can't be blank")
        end
        it 'last_nameが空では登録できない' do
          @user.last_name = ''
          @user.valid?
          expect(@user.errors.full_messages).to include("Last name can't be blank")
        end
        it 'first_nameは全角（漢字・ひらがな・カタカナ）でないと登録できない' do
          @user.first_name = 'aaa'
          @user.valid?
          expect(@user.errors.full_messages).to include('First name is invalid. Input full-width characters.')
        end
        it 'last_nameは全角（漢字・ひらがな・カタカナ）でないと登録できない' do
          @user.last_name = 'aaa'
          @user.valid?
          expect(@user.errors.full_messages).to include('Last name is invalid. Input full-width characters.')
        end
        it 'first_name_kanaが空では登録できない' do
          @user.first_name_kana = ''
          @user.valid?
          expect(@user.errors.full_messages).to include("First name kana can't be blank")
        end
        it 'last_name_kanaが空では登録できない' do
          @user.last_name_kana = ''
          @user.valid?
          expect(@user.errors.full_messages).to include("Last name kana can't be blank")
        end
        it 'first_name_kanaは全角（カタカナ）でないと登録できない' do
          @user.first_name_kana = 'riku'
          @user.valid?
          expect(@user.errors.full_messages).to include('First name kana is invalid. Input full-width characters.')
        end
        it 'last_name_kanaは全角（カタカナ）でないと登録できない' do
          @user.last_name_kana = 'yama'
          @user.valid?
          expect(@user.errors.full_messages).to include('Last name kana is invalid. Input full-width characters.')
        end
        it 'birthdayが空では登録できない' do
          @user.birthday = ''
          @user.valid?
          expect(@user.errors.full_messages).to include("Birthday can't be blank")
        end
      end
    end
  end
end
