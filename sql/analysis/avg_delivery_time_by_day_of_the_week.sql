DROP TABLE IF EXISTS avg_delivery_time_by_day_of_the_week;

CREATE TABLE avg_delivery_time_by_day_of_the_week AS
SELECT
    EXTRACT(DOW FROM "order_purchase_timestamp") AS day_of_the_week,
    ROUND((EXTRACT(EPOCH FROM 
        AVG(order_delivered_customer_date - order_purchase_timestamp)
    ) / 86400)::numeric, 2) 
    AS avg_delivery_time
FROM orders_clean
WHERE
	order_delivered_customer_date IS NOT NULL 
	AND order_purchase_timestamp IS NOT NULL
GROUP BY day_of_the_week
ORDER BY day_of_the_week;

SELECT * FROM avg_delivery_time_by_day_of_the_week