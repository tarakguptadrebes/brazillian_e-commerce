DROP TABLE IF EXISTS avg_fulfillment_duration_by_seller;

CREATE TABLE avg_fulfillment_duration_by_seller AS
WITH order_fulfillment_duration AS(
	SELECT DISTINCT
		oi.order_id,
		oi.seller_id,
		o.order_delivered_carrier_date - o.order_approved_at AS fulfillment_duration,
		o.order_delivered_customer_date - o.order_purchase_timestamp AS delivery_time
	FROM order_items_clean AS oi
	INNER JOIN orders_clean AS o
		ON oi.order_id = o.order_id
	WHERE o.order_delivered_carrier_date IS NOT NULL 
    	AND o.order_approved_at IS NOT NULL
		AND o.order_delivered_customer_date IS NOT NULL
		AND o.order_purchase_timestamp IS NOT NULL
)

SELECT 
	seller_id,
	AVG(fulfillment_duration) AS avg_fulfillment_duration,
	AVG(delivery_time) AS avg_delivery_time
FROM order_fulfillment_duration
GROUP BY seller_id;

SELECT * FROM avg_fulfillment_duration_by_seller
	
