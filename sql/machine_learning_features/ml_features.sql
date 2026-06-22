DROP TABLE IF EXISTS ml_features;

CREATE TABLE ml_features AS
WITH unique_shipments AS(
	SELECT
		oi.order_id,
		MIN(oi.seller_id) AS seller_id,
		MIN(s.seller_state) AS seller_state
	FROM order_items_clean AS oi
	INNER JOIN sellers_clean AS s
		ON oi.seller_id = s.seller_id
	GROUP BY oi.order_id
	HAVING COUNT(DISTINCT oi.seller_id) = 1
),
order_weights AS(
	SELECT 
	    oi.order_id,
	    SUM(p.product_weight_g) AS order_weight_g
	FROM order_items_clean AS oi
	INNER JOIN products_clean AS p
	    ON oi.product_id = p.product_id
	GROUP BY oi.order_id
),
order_payment_types AS(
	SELECT 
		order_id,
		MAX(CASE WHEN payment_type = 'credit_card' THEN 1 ELSE 0 END) AS credit_card,
		MAX(CASE WHEN payment_type = 'debit_card' THEN 1 ELSE 0 END) AS debit_card,
		MAX(CASE WHEN payment_type = 'voucher' THEN 1 ELSE 0 END) AS voucher,
		MAX(CASE WHEN payment_type = 'boleto' THEN 1 ELSE 0 END) AS boleto
	FROM order_payments_clean
	GROUP BY order_id
)
SELECT 
    o.order_id,
	us.seller_id,
    ROUND((EXTRACT(EPOCH FROM 
        (o.order_delivered_carrier_date - o.order_approved_at)
    ) / 86400)::numeric, 2) AS current_fulfillment_time,
    ROUND((EXTRACT(EPOCH FROM 
		(o.order_delivered_customer_date - o.order_purchase_timestamp)
	) / 86400)::numeric, 2) AS delivery_time,
    EXTRACT(DOW FROM o.order_purchase_timestamp) AS purchase_day_of_the_week,
	EXTRACT(MONTH FROM o.order_purchase_timestamp) AS purchase_month,
    h.distance,
	us.seller_state,
	c.customer_state,
	w.order_weight_g,
	p.credit_card,
	p.debit_card,
	p.voucher,
	p.boleto
FROM orders_clean AS o
INNER JOIN unique_shipments AS us
	ON o.order_id = us.order_id
INNER JOIN customers_clean AS c
	ON o.customer_id = c.customer_id
LEFT JOIN order_haversine_distance AS h
    ON o.order_id = h.order_id
LEFT JOIN order_weights AS w
	ON o.order_id = w.order_id
LEFT JOIN order_payment_types AS p
	ON o.order_id = p.order_id
WHERE o.order_purchase_timestamp IS NOT NULL
	AND o.order_approved_at IS NOT NULL
	AND o.order_delivered_carrier_date IS NOT NULL
	AND o.order_delivered_customer_date IS NOT NULL;

SELECT * FROM ml_features
