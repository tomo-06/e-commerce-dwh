# RAWデータロード

> 対象：e-commerceデータ（9CSVファイル）
> 目的：CSVファイルをSnowflakeにロードし、データごとのテーブルにCOPYする
> ロード方法：ローカルからCSVファイルをSnowflake上のOLIST_STAGEステージにPUT　⇒　OLIST_STAGEステージから各テーブルへCOPY INTOでデータ投入

---

## 事前準備

### DB/スキーマ/ファイルフォーマット/ステージ/テーブル作成
以下ファイルのクエリをSnowsightで実行して各オブジェクト作成
scripts/raw_load/01_create_raw_objects.sql


### PUT
以下ファイルのコマンドをローカルから実行し、SnowflakeのステージへCSVファイルをPUTする
scripts/raw_load/02_put_files.sql


### COPY INTO
以下ファイルのクエリをSnowsightで実行して、ステージから各テーブルへデータを投入する
scripts/raw_load/03_copy_into_raw.sql


### 突合クエリ
以下ファイルのクエリを実行して、COPY後の件数が調査時の件数と一致していることを確認
scripts/raw_load/04_reconcile_counts.sql
