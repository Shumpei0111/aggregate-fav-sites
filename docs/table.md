# テーブル設計

## テーブル一覧

### クローリングしたサイト (site)

| カラム名    | データ型  | 制約             | 備考                    |
| ----------- | --------- | ---------------- | ----------------------- |
| id          | uuid      | PK               |                         |
| url         | string    | NOT NULL, UNIQUE | インデックス推奨        |
| site_name   | string    | NOT NULL         |                         |
| description | text      |                  |                         |
| created_at  | timestamp | NOT NULL         |                         |
| updated_at  | timestamp | NOT NULL         |                         |
| category_id | uuid      | FK NOT NULL      | category テーブルを参照 |

### カテゴリ (category)

| カラム名   | データ型  | 制約             | 備考             |
| ---------- | --------- | ---------------- | ---------------- |
| id         | uuid      | PK               |                  |
| name       | string    | NOT NULL, UNIQUE | インデックス推奨 |
| created_at | timestamp | NOT NULL         |                  |
| updated_at | timestamp | NOT NULL         |                  |

### お気に入り (favorite)

| カラム名   | データ型  | 制約        | 備考                 |
| ---------- | --------- | ----------- | -------------------- |
| id         | uuid      | PK          |                      |
| user_id    | uuid      | FK NOT NULL | users テーブルを参照 |
| site_id    | uuid      | FK NOT NULL | site テーブルを参照  |
| created_at | timestamp | NOT NULL    |                      |
| updated_at | timestamp | NOT NULL    |                      |

### ユーザ (user)

| カラム名   | データ型  | 制約     | 備考 |
| ---------- | --------- | -------- | ---- |
| id         | uuid      | PK       |      |
| nick_name  | string    | NOT NULL |      |
| created_at | timestamp | NOT NULL |      |
| updated_at | timestamp | NOT NULL |      |
