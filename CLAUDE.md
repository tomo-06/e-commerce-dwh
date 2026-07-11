# CLAUDE.md

## このリポジトリについて
dbt Projects on Snowflake × Data Vault 2.0 の学習用リポジトリ。
Olist Brazilian E-Commerce データ(9テーブル、RAWスキーマにロード済み)を datavault4dbt で Raw Vault → Business Vault → Information Mart に変換する。

- 開発はVSCode(WSL2)、実行は **dbt Projects on Snowflake**。ローカルにdbt Coreはインストールしない
  - デプロイ&実行: `snow dbt deploy <object> --source .` → `snow dbt execute -x <object> run|test|deps`
  - Snowsight Workspacesは閲覧専用(DAG・リネージ・Run History)。編集はこのリポジトリ(VSCode)でのみ行う
- パッケージ: datavault4dbt(Scalefree)。dbt_project.yml のグローバル変数がコード生成を制御する
- ブランチ運用: GitHub Flow。1ブランチ = 1 Issue = 1タスク
- ブランチ横断の設計判断は claude.ai プロジェクトナレッジの design_decisions.md で管理(このリポジトリにも同名ファイルを置く場合は内容を一致させる)

## ディレクトリ構成(想定)
- `models/staging/` — datavault4dbt の stage マクロ(ハッシュキー・ハッシュディフ生成)
- `models/raw_vault/hubs|links|satellites/`
- `models/business_vault/` — PIT / Bridge
- `models/marts/` — Information Mart(スター・スキーマ)

## 命名規約
- モデル名: `stg_<source>` / `hub_<entity>` / `link_<entity1>_<entity2>` / `sat_<entity>_<内容>` / `pit_<entity>` / `dim_ / fct_`
- ブランチ名: `feat/` `chore/` `ops/` + ケバブケース(例: `feat/hub-customer`)

## あなた(Claude Code)の役割
1. **PRレビュアー**: `/review-pr` コマンドでレビューを実施し、コメントをPRに投稿する
2. **Notionログ係**: `/notion-log` コマンドでマージ済みブランチの学習ログをNotionに作成する
3. 実装コードを勝手に書き換えない。学習目的のため、修正は指摘にとどめ、本人が直す

## PRレビュー観点(チェックリスト)
### DV2.0設計
- [ ] Hub/Link/Satelliteの切り方は妥当か(Hubにビジネスキー以外の属性が混入していないか)
- [ ] ビジネスキーの選定は正しいか(Olistでは customer_unique_id と customer_id の混同に注意)
- [ ] Raw Vaultにビジネスロジック(変換・フィルタ・結合による加工)が混入していないか
- [ ] Satelliteの分割単位(変更頻度・ソース単位)は説明可能か
### datavault4dbt準拠
- [ ] 独自SQLではなくパッケージのマクロで実現しているか
- [ ] グローバル変数(ハッシュ設定、ゴーストレコード等)と個別モデルの設定が矛盾していないか
- [ ] stage層でハッシュキー・ハッシュディフが正しく定義されているか
### dbt一般
- [ ] sources.yml / schema.yml の記述、descriptionの有無
- [ ] テスト(unique / not_null / relationships、Hub主キーのユニーク性)があるか
- [ ] 命名規約への準拠
### dbt Projects on Snowflake固有
- [ ] profiles.yml の変更が実行コンテキスト前提を壊していないか
- [ ] packages.yml 変更時、deps手順(Workspace内実行)がPR説明に記載されているか

## Notionログ
- 保存先: Notionデータベース「DV2.0学習ログ」
- プロパティ: ブランチ名 / Week / 日付 / ステータス / PR URL
- 本文テンプレート: 目的 / 作業内容 / 学んだこと / 詰まった点と解決 / 設計判断とその理由 / 記事ネタメモ / 次のアクション
- 「記事ネタメモ」は後日Qiita/note記事化の材料になるため、diffやレビュー指摘から拾えるものは積極的に書く
