/*
目的：ローカルからCSVファイルをSnowflakeにPUTする
注意：Snowflakeに接続できていることが前提
*/
-- リポジトリルートで実行する前提
snow sql -q "PUT file://data/olist/olist_customers_dataset.csv @OLIST_DWH.RAW.OLIST_STAGE
  AUTO_COMPRESS = TRUE
  OVERWRITE = TRUE;" -c OLIST

snow sql -q "PUT file://data/olist/olist_geolocation_dataset.csv @OLIST_DWH.RAW.OLIST_STAGE
  AUTO_COMPRESS = TRUE
  OVERWRITE = TRUE;" -c OLIST

snow sql -q "PUT file://data/olist/olist_order_items_dataset.csv @OLIST_DWH.RAW.OLIST_STAGE
  AUTO_COMPRESS = TRUE
  OVERWRITE = TRUE;" -c OLIST

snow sql -q "PUT file://data/olist/olist_order_payments_dataset.csv @OLIST_DWH.RAW.OLIST_STAGE
  AUTO_COMPRESS = TRUE
  OVERWRITE = TRUE;" -c OLIST

snow sql -q "PUT file://data/olist/olist_order_reviews_dataset.csv @OLIST_DWH.RAW.OLIST_STAGE
  AUTO_COMPRESS = TRUE
  OVERWRITE = TRUE;" -c OLIST

snow sql -q "PUT file://data/olist/olist_orders_dataset.csv @OLIST_DWH.RAW.OLIST_STAGE
  AUTO_COMPRESS = TRUE
  OVERWRITE = TRUE;" -c OLIST

snow sql -q "PUT file://data/olist/olist_products_dataset.csv @OLIST_DWH.RAW.OLIST_STAGE
  AUTO_COMPRESS = TRUE
  OVERWRITE = TRUE;" -c OLIST

snow sql -q "PUT file://data/olist/olist_sellers_dataset.csv @OLIST_DWH.RAW.OLIST_STAGE
  AUTO_COMPRESS = TRUE
  OVERWRITE = TRUE;" -c OLIST

snow sql -q "PUT file://data/olist/product_category_name_translation.csv @OLIST_DWH.RAW.OLIST_STAGE
  AUTO_COMPRESS = TRUE
  OVERWRITE = TRUE;" -c OLIST
