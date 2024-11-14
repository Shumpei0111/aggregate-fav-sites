```
root/
├── src/ # フロントエンド
├── data/
│ └── postgres/ # PostgreSQL のデータがここに保存される
├── scripts/ # バッチ処理
├── node_modules/
├── package.json
├── docker-compose.yml
└── .gitignore # data/postgres/ を除外するように設定
```

### ローカルでの開発（DB 構築手順）

1. ローカルで PostgreSQL を起動する

```bash
docker compose up -d
```

2. DB を作成

今回は init.sql を実行してテーブルを作成した。

3. Prisma のモデルを作成

.env に DATABASE_URL を設定する。

```bash
DATABASE_URL="postgresql://username:password@localhost:5432/your_database_name?schema=public"
```

```bash
npx prisma db pull
```

`prisma/schema.prisma` に既存のデータベース構造が反映される。

4. Prisma のモデルを更新

```bash
npx prisma generate
```

### メモ

型の更新:

- スキーマを変更した後は、`npx prisma generate`コマンドを実行して型を再生成する必要があります。
- このコマンドは、`schema.prisma`ファイルの内容に基づいて型を更新します。
