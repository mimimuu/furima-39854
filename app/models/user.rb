class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :password,
            format: { with: /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i,
                      message: 'is invalid. Input half-width alphanumeric characters.' }
  validates :nickname, presence: true
  validates :birthday, presence: true

  with_options presence: true do
    validates :first_name, format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: 'is invalid. Input full-width characters.' }
    validates :last_name, format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: 'is invalid. Input full-width characters.' }
    validates :first_name_kana, format: { with: /\A[ァ-ヶー]+\z/, message: 'is invalid. Input full-width characters.' }
    validates :last_name_kana, format: { with: /\A[ァ-ヶー]+\z/, message: 'is invalid. Input full-width characters.' }
  end
end
