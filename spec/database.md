# Database
内容の説明
### 型
- NULL: 値がない状態
- INTEGER: 整数
- REAL: 小数
- TEXT: 文字列
- DATETIME: 日時
### 制約
- UNIQUE: 値の重複を許さない
- NOT NULL: NULLを許さない（値を必ず入れる）
- FOREIGN KEY: 外部キー（別テーブルで登録されたもののみ使用できる）

# テーブル
## Todo
タスクを管理するテーブル

| カラム名 | 論理名 | 型 | 制約 | 説明 |
| --- | --- | --- | --- | --- |
| id | ID | INTEGER | UNIQUE, AUTO INCREMENT, NOT NULL | 管理するためのID |
| name | タスク名 | TEXT | NOT NULL | タスク名 |
| span | スパン | INTEGER | NOT NULL | ○日に一回、週1なら7、月1なら30 |
| remind | リマインド | INTEGER | NOT NULL | ありなら1、なしなら0 |
| time | 要する時間 | INTEGER | | 分で指定 |
| count | 実施回数 | INTEGER | NOT NULL | タスク実施回数 |
| skip_count | スキップ回数 | INTEGER | NOT NULL | タスクスキップ回数 |
| skip_consecutive | 連続スキップ回数 | INTEGER | NOT NULL | タスク連続スキップ回数、実施したら0にリセット |
| category_id | 分類 | TEXT | FOREIGN KEY | 分類をカラーコードで指定、複数可(List<String>) |
| date | 実施日 | DATETIME | NOT NULL | 次回実施日 |
| begin_date | 開始日時 | DATETIME | NOT NULL | 初回実施日 |
| created_at | 作成日時 | DATETIME | NOT NULL | 作成時間 |
| updated_at | 更新日時 | DATETIME | NOT NULL | 更新時間 |

## category
カテゴリ名を管理するテーブル
| カラム名 | 論理名 | 型 | 制約 | 説明 |
| --- | --- | --- | --- | --- |
| category_id | カテゴリid | TEXT | UNIQUE, NOT NULL | 色コード(「AA00CC」など) |
| name | カテゴリ名 | TEXT | | カテゴリに各々がつけた名前（「勉強」「掃除」など） |
