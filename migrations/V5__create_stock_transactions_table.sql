CREATE TABLE stock_transactions (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,

    product_id BIGINT NOT NULL,
    warehouse_id BIGINT NOT NULL,
    user_id BIGINT NOT NULL,

    transaction_type VARCHAR(30) NOT NULL
        CHECK (
            transaction_type IN (
                'IN',
                'OUT',
                'TRANSFER_IN',
                'TRANSFER_OUT',
                'ADJUSTMENT'
            )
        ),

    quantity INTEGER NOT NULL
        CHECK (quantity <> 0),

    reference_id UUID,
    reference_type VARCHAR(30),

    note TEXT,

    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),

    CONSTRAINT ck_transaction_quantity_sign
        CHECK (
            (transaction_type IN ('IN', 'TRANSFER_IN') AND quantity > 0)
            OR
            (transaction_type IN ('OUT', 'TRANSFER_OUT') AND quantity < 0)
            OR
            (transaction_type = 'ADJUSTMENT')
        ),

    CONSTRAINT fk_transaction_product
        FOREIGN KEY (product_id)
        REFERENCES products(id)
        ON DELETE RESTRICT,

    CONSTRAINT fk_transaction_warehouse
        FOREIGN KEY (warehouse_id)
        REFERENCES warehouses(id)
        ON DELETE RESTRICT,

    CONSTRAINT fk_transaction_user
        FOREIGN KEY (user_id)
        REFERENCES users(id)
        ON DELETE RESTRICT
);
