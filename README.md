# テーブル設計

## users テーブル

| Column             | Type   | Options                   |
| ------------------ | ------ | -----------               |
| nickname           | string | null: false               |
| email              | string | null: false, unique: true |
| password           | string | null: false               |
| encrypted_password | string | null: false               |
| first_name         | string | null: false               |
| last_name          | string | null: false               |
| first_name_kana    | string | null: false               |
| last_name_kana     | string | null: false               |
| birthday           | date   | null: false               |

### Association

- has_many :items
- has_many :orders

## items テーブル

| Column           | Type      | Options                        |
| ---------------- | --------- | ------------------------------ |
| item_name        | string    | null: false                    |
| item_description | text      | null: false                    |
| item_category    | integer   | null: false                    |
| item_status      | integer   | null: false                    |
| delivery_charge  | integer   | null: false                    |
| shipping_area    | integer   | null: false                    |
| shipping_days    | integer   | null: false                    |
| Selling_price    | integer   | null: false                    |
| user             | reference | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_one :order

## orders テーブル

| Column        | Type      | Options                        |
| ------------- | --------- | ------------------------------ |
| user          | reference | null: false, foreign_key: true |
| item          | reference | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item
- has_one :address


## address テーブル

| Column         | Type      | Options                        |
| -------------- | --------- | ------------------------------ |
| postal_code    | string    | null: false                    |
| prefectures    | integer   | null: false                    |
| municipality   | string    | null: false                    |
| address_number | string    | null: false                    |
| building_name  | string    |                                |
| phone_number   | integer   | null: false                    |
| order          | reference | null: false, foreign_key: true |


### Association
- belongs_to :order