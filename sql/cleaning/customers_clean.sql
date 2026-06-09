CREATE EXTENSION IF NOT EXISTS unaccent;

DROP TABLE IF EXISTS customers_clean;

CREATE TABLE customers_clean AS

SELECT
	customer_id,
	customer_unique_id,
	customer_zip_code_prefix,
	TRIM(
		regexp_replace(
			regexp_replace(
				unaccent(LOWER(customer_city)), 
				'[^a-z ]', ' ', 'g'
			), 
			'\s+', ' ', 'g'
		)
	) AS customer_city,
	TRIM(LOWER(customer_state)) AS customer_state
FROM olist_customers;

SELECT * FROM customers_clean