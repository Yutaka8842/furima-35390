# テーブル設計

## users テーブル

| Column                | Type    | Options     |
| --------------------- | ------- | ----------- |
| nickname              | string  | null: false |
| email                 | string  | null: false |
| password              | string  | null: false |
| password_confirmation | string  | null: false |
| first_name            | string  | null: false |
| last_name             | string  | null: false |
| first_name_kana       | string  | null: false |
| last_name_kana        | string  | null: false |
| birth_year            | integer | null: false |
| birth_month           | integer | null: false |
| birth_day             | integer | null: false |

### Association

- has_many :items
- has_many :orders

## items テーブル

| Column           | Type      | Options                        |
| ---------------- | --------- | ------------------------------ |
| image            | string    | null: false                    |
| item_name        | string    | null: false                    |
| item_description | text      | null: false                    |
| item_category    | string    | null: false                    |
| item_status      | string    | null: false                    |
| delivery_charge  | string    | null: false                    |
| shipping_area    | string    | null: false                    |
| shipping_days    | string    | null: false                    |
| Selling_price    | integer   | null: false                    |
| user             | reference | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_one :item

## orders テーブル

| Column        | Type      | Options                        |
| ------------- | --------- | ------------------------------ |
| card_number   | integer   | null: false                    |
| valid_month   | integer   | null: false                    |
| valid_year    | integer   | null: false                    |
| security_code | integer   | null: false                    |
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
| prefectures    | string    | null: false                    |
| municipality   | string    | null: false                    |
| address_number | string    | null: false                    |
| building_name  | string    |                                |
| phone_number   | integer   | null: false                    |
| user           | reference | null: false, foreign_key: true |
| item           | reference | null: false, foreign_key: true |
| order          | reference | null: false, foreign_key: true |


### Association

- belongs_to :user
- belongs_to :item
- belongs_to :order