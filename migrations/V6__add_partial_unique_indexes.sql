-- Active users must have unique emails
CREATE UNIQUE INDEX ux_users_email_active
ON users(email)
WHERE is_active = TRUE;

CREATE UNIQUE INDEX ux_products_sku
ON products(sku);

-- Active warehouse names must be unique
CREATE UNIQUE INDEX ux_warehouses_name_active
ON warehouses(name)
WHERE is_active = TRUE;

-- Reporting indexes
CREATE INDEX idx_inventory_product
ON inventory(product_id);

CREATE INDEX idx_inventory_warehouse
ON inventory(warehouse_id);

CREATE INDEX idx_stock_transactions_product
ON stock_transactions(product_id);

CREATE INDEX idx_stock_transactions_warehouse
ON stock_transactions(warehouse_id);

CREATE INDEX idx_stock_transactions_created_at
ON stock_transactions(created_at);

CREATE INDEX idx_stock_transactions_reference
ON stock_transactions(reference_id);

CREATE INDEX idx_stock_transactions_user
ON stock_transactions(user_id);
