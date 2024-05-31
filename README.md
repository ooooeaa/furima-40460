# テーブル設計

## users テーブル

| Column             | Type   | Options     |
| ------------------ | ------ | ----------- |
| nickname           | string | null: false |
| email              | string | null: false, unique: true |
| password           | string | null: false |
| last-name          | string | null: false |
| first-name         | string | null: false |
| last-name-kana     | string | null: false |
| first-name-kana    | string | null: false |

### Association

- has_many :items
- has_many :payments
- has_many :addresses

## items テーブル

| Colum                    | Type   | Options     |
| ------------------------ | ------ | ----------- |
| item-name                | string | null: false |
| item-explain             | text   | null: false |
| item-category            | string | null: false |
| item-sales-status        | string | null: false |
| item-shipping-fee-status | string | null: false |
| item-prefecture          | string | null: false |
| item-scheduled-delivery  | string | null: false |
| item-price               | string | null: false |


### Association

- has_one :payments
- has_one :addresses
- belongs_to :users

## payments テーブル

| Colum                    | Type       | Options     |
| ------------------------ | ---------- | ----------- |
| number-form              | string     | null: false |
| expiry-form              | string     | null: false |
| cvc-form                 | string     | null: false |
| user                     | references | null: false, foreign_key: true |
| item                     | references | null: false, foreign_key: true |

### Association

- belongs_to :users
- belongs_to :items

## addresses テーブル

| Colum                    | Type       | Options     |
| ------------------------ | ---------- | ----------- |
| postal-code              | string     | null: false |
| prefecture               | string     | null: false |
| city                     | string     | null: false |
| addresses                | string     | null: false |
| building                 | string     | null: false |
| phone-number             | string     | null: false |
| user                     | references | null: false, foreign_key: true |
| item                     | references | null: false, foreign_key: true |

### Association

- belongs_to :users
- belongs_to :items
