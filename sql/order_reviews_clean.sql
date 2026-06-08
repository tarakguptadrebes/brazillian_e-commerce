DROP TABLE IF EXISTS order_reviews_clean;

CREATE TABLE order_reviews_clean AS
SELECT
	review_id,
	order_id,
	review_score,
	review_comment_title,
	review_comment_message,
	review_creation_date::timestamp,
	review_answer_timestamp::timestamp
FROM olist_order_reviews;

SELECT * FROM order_reviews_clean
