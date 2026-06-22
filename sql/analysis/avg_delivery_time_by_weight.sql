DROP TABLE IF EXISTS avg_delivery_time_by_weight;

CREATE TABLE avg_delivery_time_by_weight AS
WITH order_weights AS(
	SELECT 
	    oi.order_id,
	    SUM(p.product_weight_g) AS order_weight_g,
	    ROUND((EXTRACT(EPOCH FROM 
	        MAX(o.order_delivered_customer_date) - MAX(o.order_purchase_timestamp)
	    ) / 86400)::numeric, 2) AS delivery_time
	FROM order_items_clean AS oi
	INNER JOIN products_clean AS p
	    ON oi.product_id = p.product_id
	INNER JOIN orders_clean AS o
	    ON oi.order_id = o.order_id
	GROUP BY oi.order_id
)

SELECT
	CASE
		WHEN order_weight_g < 1000  THEN '<1kg'
    	WHEN order_weight_g < 10000 THEN '>=1kg & <10kg'
    	ELSE '>=10kg'
	END AS weight_class,
	AVG(delivery_time) AS avg_delivery_time
FROM order_weights
GROUP BY weight_class
ORDER BY avg_delivery_time;

SELECT * FROM avg_delivery_time_by_weight





