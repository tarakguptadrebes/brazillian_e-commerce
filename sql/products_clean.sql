DROP TABLE IF EXISTS products_clean;

CREATE TABLE products_clean AS
SELECT 
	p.product_id,
	t.product_category_name_english,
	p.product_name_lenght AS product_name_length,
	p.product_description_lenght AS product_description_length,
	p.product_photos_qty,
	p.product_weight_g,
	p.product_length_cm,
	p.product_height_cm,
	p.product_width_cm
FROM olist_products AS p
LEFT JOIN product_category_name_translation_clean AS t
	ON p.product_category_name = t.product_category_name;

SELECT * FROM products_clean
