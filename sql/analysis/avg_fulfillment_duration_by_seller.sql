DROP TABLE IF EXISTS avg_fulfillment_duration_by_seller;

CREATE TABLE avg_fulfillment_duration_by_seller AS
WITH order_fulfillment_duration AS (
    SELECT
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
    ROUND((EXTRACT(EPOCH FROM AVG(fulfillment_duration)) / 86400)::numeric, 2) AS avg_fulfillment_duration_days,
    ROUND((EXTRACT(EPOCH FROM AVG(delivery_time)) / 86400)::numeric, 2) AS avg_delivery_time_days
FROM order_fulfillment_duration
GROUP BY seller_id;

SELECT * FROM avg_fulfillment_duration_by_seller;
	
