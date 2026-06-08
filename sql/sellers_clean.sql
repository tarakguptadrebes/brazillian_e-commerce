DROP TABLE IF EXISTS sellers_clean;

CREATE TABLE sellers_clean AS
SELECT 
	seller_id,
	seller_zip_code_prefix,
	TRIM(
		regexp_replace(
			regexp_replace(
				unaccent(LOWER(seller_city)), 
				'[^a-z ]', ' ', 'g'
			), 
			'\s+', ' ', 'g'
		)
	) AS seller_city,
	TRIM(LOWER(seller_state)) AS seller_state
FROM olist_sellers;

SELECT * FROM sellers_clean
