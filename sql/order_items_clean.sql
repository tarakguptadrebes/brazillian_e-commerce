DROP TABLE IF EXISTS order_items_clean;

CREATE TABLE order_items_clean AS
SELECT
	order_id,
	order_item_id,
	product_id,
	seller_id,
	shipping_limit_date::timestamp,
	price,
	freight_value
FROM olist_order_items;

SELECT * FROM order_items_clean
