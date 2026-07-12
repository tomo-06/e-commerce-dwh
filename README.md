# e-commerce-dwh

Olist Brazilian E-Commerce データセットを題材に、
dbt Projects on Snowflake + datavault4dbt で Data Vault 2.0 を構築する学習プロジェクト。

## スタック
- 実行基盤: dbt Projects on Snowflake(ローカル dbt Core / dbt Cloud は不使用)
- モデリング: Data Vault 2.0(datavault4dbt / Scalefree)
- ソースデータ: Olist(Kaggle、9テーブル)を RAW スキーマにロード

## ディレクトリ
- models/staging … ステージング層(ハッシュキー等の付与)
- models/raw_vault … Hub / Link / Satellite
- models/business_vault … PIT / Bridge
- models/marts … Information Mart

## 実行方法
編集は VSCode(WSL2)、実行は Snowflake CLI 経由(実行自体は Snowflake 内)。

    # dev 用 DBT PROJECT オブジェクトへデプロイ
    snow dbt deploy <dev用オブジェクト名> --source .

    # 実行
    snow dbt execute -x <dev用オブジェクト名> run
    snow dbt execute -x <dev用オブジェクト名> test

注意: dbt deps は EXECUTE DBT PROJECT では実行不可。Workspace 内または Snowflake CLI から実行する。

## 開発フロー
GitHub Flow。1 Issue = 1 ブランチ(feature/<issue番号>-<説明>)= 半日〜1日。
main マージ後、本番用 DBT PROJECT オブジェクトへ deploy。