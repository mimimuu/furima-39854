# README

## usersテーブル

| Column                | Type       | Options                        |
| --------------------- | ---------- | ------------------------------ |
| nickname              | string     | null: false, unique: true      |
| email                 | string     | null: false                    |
| password              | string     | null: false                    |
| first_name            | string     | null: false                    |
| last_name             | string     | null: false                    |
| first_name_kana       | string     | null: false                    |
| last_name_kana        | string     | null: false                    |
| birthday              | date       | null: false                    |

### Association
- has_many  :items
- has_one   :card
- has_one   :detail

## itemsテーブル

| Column                | Type       | Options                        |
| --------------------- | ---------- | ------------------------------ |
| image                 | text       | null: false                    |
| name                  | string     | null: false                    |
| content               | text       | null: false                    |
| category              | string     | null: false, foreign_key: true |
| condition             | string     | null: false                    |
| shipping_fee_burden   | string     | null: false                    |
| shipping_area         | string     | null: false                    |
| days_until_shipping   | string     | null: false, foreign_key: true |
| selling_price         | integer    | null: false, foreign_key: true |
| user_id               | references | null: false, foreign_key: true |

### Association
- belongs_to :users
- has_one :deliveries


## deliveriesテーブル

| Column        | Type       | Options                        |
| ------------- | ---------- | ------------------------------ |
| post_code     | string     | null: false                    |
| prefectures   | string     | null: false, foreign_key: true |
| municipalities| string     | null: false, foreign_key: true |
| street_address| string     | null: false, foreign_key: true |
| building_name | string     | null: false                    |
| telephone_num | integer    | null: false, foreign_key: true |
| user_id       | references | null: false, foreign_key: true |
| item_id       | references | null: false, foreign_key: true |
| cord_id       | references | null: false, foreign_key: true |

### Association
- belongs_to :users
- belongs_to :items
- belongs_to :cards

## ordersテーブル

| Column        | Type       | Options                        |
| ------------- | ---------- | ------------------------------ |
| user_id       | references | null: false, foreign_key: true |
| item_id       | references | null: false, foreign_key: true |
| delivery_id   | references | null: false, foreign_key: true |