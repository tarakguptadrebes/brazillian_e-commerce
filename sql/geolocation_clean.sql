CREATE EXTENSION IF NOT EXISTS unaccent;

DROP TABLE IF EXISTS geolocation_clean;

CREATE TABLE geolocation_clean AS

WITH clean AS(
	SELECT
		geolocation_zip_code_prefix,
		geolocation_lat,
		geolocation_lng,
		TRIM(
		    regexp_replace(
		        regexp_replace(
		            unaccent(LOWER(geolocation_city)), 
		            '[^a-z ]', ' ', 'g'
		        ), 
		        '\s+', ' ', 'g'
		    )
		) AS geolocation_city,
		TRIM(LOWER(geolocation_state)) AS geolocation_state
	FROM olist_geolocation
	WHERE geolocation_lat BETWEEN -33.8 AND 5.3
		AND geolocation_lng BETWEEN -74.0 AND -34.8
)

SELECT 
	geolocation_zip_code_prefix,
	AVG(geolocation_lat) AS geolocation_lat,
	AVG(geolocation_lng) AS geolocation_lng,
	geolocation_city,
	geolocation_state
FROM clean
GROUP BY geolocation_zip_code_prefix, geolocation_city, geolocation_state;

SELECT * FROM geolocation_clean