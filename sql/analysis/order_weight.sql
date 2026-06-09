DROP TABLE IF EXISTS order_weight;

CREATE TABLE order_weight AS
SELECT 
	oi.order_id,
	SUM(p.product_weight_g) AS order_weight_g
FROM order_items_clean AS oi
INNER JOIN products_clean AS p
	ON oi.product_id = p.product_id
GROUP BY oi.order_id;

SELECT * FROM order_weight


