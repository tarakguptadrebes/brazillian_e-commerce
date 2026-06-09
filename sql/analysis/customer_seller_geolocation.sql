DROP TABLE IF EXISTS customer_seller_geolocation;

CREATE TABLE customer_seller_geolocation AS
SELECT
	oi.order_id,
	gc.geolocation_lat AS geolocation_lat_customer,
	gc.geolocation_lng AS geolocation_lng_customer,
	gs.geolocation_lat AS geolocation_lat_seller,
	gs.geolocation_lng AS geolocation_lng_seller
FROM order_items_clean AS oi
INNER JOIN orders_clean AS o
	ON oi.order_id = o.order_id
INNER JOIN customers_clean AS c
	ON o.customer_id = c.customer_id
INNER JOIN sellers_clean AS s
	ON oi.seller_id = s.seller_id
INNER JOIN geolocation_clean AS gc
	ON c.customer_zip_code_prefix = gc.geolocation_zip_code_prefix 
INNER JOIN geolocation_clean AS gs
	ON s.seller_zip_code_prefix = gs.geolocation_zip_code_prefix;

SELECT * FROM customer_seller_geolocation
