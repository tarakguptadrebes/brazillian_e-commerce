DROP TABLE IF EXISTS order_payments_clean;

CREATE TABLE order_payments_clean AS
SELECT 
	order_id,
	payment_sequential,
	NULLIF(payment_type,'not_defined') AS payment_type,
	payment_installments,
	payment_value
FROM olist_order_payments;

SELECT * FROM order_payments_clean

