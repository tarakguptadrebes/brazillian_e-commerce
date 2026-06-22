DROP TABLE IF EXISTS transit_time_with_distance;

CREATE TABLE transit_time_with_distance AS
SELECT 
	d.distance,
	ROUND((EXTRACT(EPOCH FROM 
    	(o.order_delivered_customer_date - o.order_delivered_carrier_date)
	) / 86400)::numeric, 2) AS transit_time
FROM orders_clean AS o
INNER JOIN order_haversine_distance AS d
	ON o.order_id = d.order_id;

SELECT * FROM transit_time_with_distance
