DROP TABLE IF EXISTS orders_clean;

CREATE TABLE orders_clean AS
SELECT
	order_id,
	customer_id,
	order_status,
	order_purchase_timestamp::timestamp,
	order_approved_at::timestamp,
	order_delivered_carrier_date::timestamp,
	order_delivered_customer_date::timestamp,
	order_estimated_delivery_date::timestamp
FROM olist_orders;

SELECT * FROM orders_clean
