DROP TABLE IF EXISTS avg_delivery_time_by_month;

CREATE TABLE avg_delivery_time_by_month AS
SELECT
    EXTRACT(MONTH FROM "order_purchase_timestamp") AS purchase_month,
    ROUND((EXTRACT(EPOCH FROM 
        AVG(order_delivered_customer_date - order_purchase_timestamp)
    ) / 86400)::numeric, 2) 
    AS avg_delivery_time
FROM orders_clean
WHERE
	order_delivered_customer_date IS NOT NULL 
	AND order_purchase_timestamp IS NOT NULL
GROUP BY purchase_month
ORDER BY purchase_month;

SELECT * FROM avg_delivery_time_by_month