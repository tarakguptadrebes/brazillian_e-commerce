CREATE INDEX IF NOT EXISTS idx_c_customer_id ON customers_clean(customer_id);
CREATE INDEX IF NOT EXISTS idx_c_zip ON customers_clean(customer_zip_code_prefix);

CREATE INDEX IF NOT EXISTS idx_geo_zip ON geolocation_clean(geolocation_zip_code_prefix);

CREATE INDEX IF NOT EXISTS idx_o_order_id ON orders_clean(order_id);
CREATE INDEX IF NOT EXISTS idx_o_customer_id ON orders_clean(customer_id);

CREATE INDEX IF NOT EXISTS idx_oi_order_id ON order_items_clean(order_id);
CREATE INDEX IF NOT EXISTS idx_oi_product_id ON order_items_clean(product_id);
CREATE INDEX IF NOT EXISTS idx_oi_seller_id ON order_items_clean(seller_id);

CREATE INDEX IF NOT EXISTS idx_pay_order_id ON order_payments_clean(order_id);

CREATE INDEX IF NOT EXISTS idx_rev_order_id ON order_reviews_clean(order_id);

CREATE INDEX IF NOT EXISTS idx_p_product_id ON products_clean(product_id);

CREATE INDEX IF NOT EXISTS idx_s_seller_id ON sellers_clean(seller_id);
CREATE INDEX IF NOT EXISTS idx_s_zip ON sellers_clean(seller_zip_code_prefix);