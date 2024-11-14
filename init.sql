-- UUID拡張機能の有効化
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- ユーザテーブルの作成
CREATE TABLE "user" (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    nick_name VARCHAR(255) NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- カテゴリテーブルの作成
CREATE TABLE category (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name VARCHAR(255) NOT NULL UNIQUE,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- カテゴリ名にインデックスを作成
CREATE INDEX idx_category_name ON category(name);

-- クローリングしたサイトテーブルの作成
CREATE TABLE site (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    url VARCHAR(2083) NOT NULL UNIQUE,
    site_name VARCHAR(255) NOT NULL,
    description TEXT,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    category_id UUID NOT NULL REFERENCES category(id)
);

-- サイトのURLにインデックスを作成
CREATE INDEX idx_site_url ON site(url);

-- お気に入りテーブルの作成
CREATE TABLE favorite (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID NOT NULL REFERENCES "user"(id),
    site_id UUID NOT NULL REFERENCES site(id),
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- 更新時のタイムスタンプを自動更新する関数
CREATE OR REPLACE FUNCTION update_modified_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ language 'plpgsql';

-- 各テーブルに更新トリガーを設定
CREATE TRIGGER update_user_modtime
    BEFORE UPDATE ON "user"
    FOR EACH ROW
    EXECUTE FUNCTION update_modified_column();

CREATE TRIGGER update_category_modtime
    BEFORE UPDATE ON category
    FOR EACH ROW
    EXECUTE FUNCTION update_modified_column();

CREATE TRIGGER update_site_modtime
    BEFORE UPDATE ON site
    FOR EACH ROW
    EXECUTE FUNCTION update_modified_column();

CREATE TRIGGER update_favorite_modtime
    BEFORE UPDATE ON favorite
    FOR EACH ROW
    EXECUTE FUNCTION update_modified_column();