DROP TABLE IF EXISTS avg_approval_time_by_payment_type;

CREATE TABLE avg_approval_time_by_payment_type AS
SELECT
	op.payment_type,
	ROUND((EXTRACT(EPOCH FROM 
		AVG(o.order_approved_at-o.order_purchase_timestamp)
	) / 86400)::numeric, 2)
	AS avg_approval_time
FROM orders_clean AS o
INNER JOIN order_payments_clean AS op
	ON o.order_id = op.order_id
WHERE op.payment_type IS NOT NULL
GROUP BY op.payment_type;

SELECT * FROM avg_approval_time_by_payment_type
