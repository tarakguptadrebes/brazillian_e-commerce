DROP TABLE IF EXISTS delivery_time_by_state;

CREATE TABLE delivery_time_by_state AS
WITH single_state_orders AS(
	SELECT
		oi.order_id,
		MIN(s.seller_state) AS seller_state
	FROM order_items_clean AS oi
	INNER JOIN sellers_clean AS s
		ON oi.seller_id = s.seller_id
	GROUP BY oi.order_id
	HAVING COUNT(DISTINCT s.seller_state) = 1
)
SELECT
	o.order_id,
	ROUND((EXTRACT(EPOCH FROM 
        (order_delivered_customer_date - order_purchase_timestamp)
    ) / 86400)::numeric, 2) AS delivery_time,
	c.customer_state,
	st.seller_state
FROM orders_clean AS o
INNER JOIN customers_clean AS c
	ON o.customer_id = c.customer_id
INNER JOIN single_state_orders AS st
	ON o.order_id = st.order_id
WHERE o.order_delivered_customer_date IS NOT NULL
	AND o.order_purchase_timestamp IS NOT NULL;

SELECT * FROM delivery_time_by_state
