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
| category | 分類 | TEXT | | 分類を文字列で指定 |
| date | 実施日 | DATETIME | NOT NULL | 次回実施日 |
| created_at | 作成時間 | DATETIME | NOT NULL | 作成時間 |
| updated_at | 更新時間 | DATETIME | NOT NULL | 更新時間 |