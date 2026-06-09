DROP TABLE IF EXISTS product_category_name_translation_clean;

CREATE TABLE product_category_name_translation_clean AS
SELECT * FROM product_category_name_translation;

INSERT INTO product_category_name_translation_clean(
	product_category_name,
	product_category_name_english
)
VALUES
	('pc_gamer','pc_gamer'),
	('portateis_cozinha_e_preparadores_de_alimentos','kitchen_and_food_preparers');

SELECT * FROM product_category_name_translation_clean

