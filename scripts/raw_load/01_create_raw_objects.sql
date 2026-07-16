-- 実行コンテキスト(role/warehouseも明示しておくと手順書として自己完結する)
USE ROLE SYSADMIN;
USE WAREHOUSE COMPUTE_WH;

-- ① DB・スキーマ: データを持つ器なので IF NOT EXISTS(OR REPLACEは事故のもと)
CREATE DATABASE IF NOT EXISTS OLIST_DWH;
CREATE SCHEMA IF NOT EXISTS OLIST_DWH.RAW;

USE SCHEMA OLIST_DWH.RAW;

-- ② ファイルフォーマット: 定義のみなので OR REPLACE で可
CREATE OR REPLACE FILE FORMAT CSV_OLIST_FORMAT
    TYPE                         = 'CSV'
    SKIP_HEADER                  = 1
    FIELD_DELIMITER              = ','
    FIELD_OPTIONALLY_ENCLOSED_BY = '"'
    ESCAPE_UNENCLOSED_FIELD      = NONE   -- デフォルトの'\'エスケープを無効化(自由記述対策)
;

-- ステージ: 内部ステージはPUTしたファイルを保持するため、
-- ロード運用開始後の再実行(OR REPLACE)には注意
CREATE STAGE IF NOT EXISTS OLIST_STAGE
    FILE_FORMAT = CSV_OLIST_FORMAT;


/*
目的：RAWデータ（9CSVファイル）を格納するテーブルを作成
注意：ロード時の取込エラーが発生しないようにデータ型をVARCHARで統一しておく。
　　　※後から各項目に合わせたデータ型にCASTすれば問題ない
*/
CREATE IF NOT EXISTS TABLE OLIST_DWH.RAW.OLIST_CUSTOMERS_DATASET (
    customer_id VARCHAR,
    customer_unique_id VARCHAR,
    customer_zip_code_prefix VARCHAR,
    customer_city VARCHAR,
    customer_state VARCHAR
);


CREATE IF NOT EXISTS TABLE OLIST_DWH.RAW.OLIST_ORDERS_DATASET (
    order_id VARCHAR,
    customer_id VARCHAR,
    order_status VARCHAR,
    order_purchase_timestamp VARCHAR,
    order_approved_at VARCHAR,
    order_delivered_carrier_date VARCHAR,
    order_delivered_customer_date VARCHAR,
    order_estimated_delivery_date VARCHAR
);


CREATE IF NOT EXISTS TABLE OLIST_DWH.RAW.OLIST_PRODUCTS_DATASET (
    product_id VARCHAR,
    product_category_name VARCHAR,
    product_name_lenght VARCHAR,
    product_description_lenght VARCHAR,
    product_photos_qty VARCHAR,
    product_weight_g VARCHAR,
    product_length_cm VARCHAR,
    product_height_cm VARCHAR,
    product_width_cm VARCHAR
);


CREATE IF NOT EXISTS TABLE OLIST_DWH.RAW.OLIST_SELLERS_DATASET (
    seller_id VARCHAR,
    seller_zip_code_prefix VARCHAR,
    seller_city VARCHAR,
    seller_state VARCHAR
);


CREATE IF NOT EXISTS TABLE OLIST_DWH.RAW.OLIST_ORDER_ITEMS_DATASET (
    order_id VARCHAR,
    order_item_id VARCHAR,
    product_id VARCHAR,
    seller_id VARCHAR,
    shipping_limit_date VARCHAR,
    price VARCHAR,
    freight_value VARCHAR
);


CREATE IF NOT EXISTS TABLE OLIST_DWH.RAW.OLIST_ORDER_REVIEWS_DATASET (
    review_id VARCHAR,
    order_id VARCHAR,
    review_score VARCHAR,
    review_comment_title VARCHAR,
    review_comment_message VARCHAR,
    review_creation_date VARCHAR,
    review_answer_timestamp VARCHAR
);


CREATE IF NOT EXISTS TABLE OLIST_DWH.RAW.OLIST_ORDER_PAYMENTS_DATASET (
    order_id VARCHAR,
    payment_sequential VARCHAR,
    payment_type VARCHAR,
    payment_installments VARCHAR,
    payment_value VARCHAR
);


CREATE IF NOT EXISTS TABLE OLIST_DWH.RAW.OLIST_GEOLOCATION_DATASET (
    geolocation_zip_code_prefix VARCHAR,
    geolocation_lat VARCHAR,
    geolocation_lng VARCHAR,
    geolocation_city VARCHAR,
    geolocation_state VARCHAR
);


CREATE IF NOT EXISTS TABLE OLIST_DWH.RAW.PRODUCT_CATEGORY_NAME_TRANSLATION (
    product_category_name VARCHAR,
    product_category_name_english VARCHAR
);
