/*
This schema defines a relational database structure for a receipt processing and rewards 
system. The structure consists of four main tables (users, brands, receipts, and receipt_items) 
along with three materialized views designed to support receipt analysis and brand performance 
tracking. 

The core tables are structured as follows: The users table stores basic user information and 
tracks activity status; the brands table contains reference data for product identification 
and categorization; the receipts table serves as the main transaction table recording metadata 
and rewards information; and the receipt_items table stores line-item details including pricing 
and quantity information.

Performance optimizations include strategic indexing for common join operations and 
user/date-based queries. Three materialized views are implemented: receipt_status_metrics 
for comparing accepted vs rejected receipts, monthly_brand_metrics for tracking brand 
performance over time, and recent_user_brand_metrics for analyzing new user behavior. The 
schema follows a normalized structure to minimize data redundancy while supporting high-volume 
receipt processing and efficient reward calculation.
*/
-- Base Tables

-- Users table
CREATE TABLE users (
    user_id VARCHAR(50) NOT NULL,
    state CHAR(2),
    created_date TIMESTAMP NOT NULL,
    last_login TIMESTAMP,
    role VARCHAR(50) DEFAULT 'CONSUMER',
    active BOOLEAN DEFAULT true,
    CONSTRAINT pk_users PRIMARY KEY (user_id)
);

-- Brands table
CREATE TABLE brands (
    barcode VARCHAR(50) NOT NULL,
    brand_code VARCHAR(50),
    category VARCHAR(100),
    category_code VARCHAR(50),
    name VARCHAR(255) NOT NULL,
    is_top_brand BOOLEAN DEFAULT false,
    CONSTRAINT pk_brands PRIMARY KEY (barcode)
);

-- Receipts table
CREATE TABLE receipts (
    receipt_id VARCHAR(50) PRIMARY KEY NOT NULL,
    bonus_points_earned INTEGER,
    bonus_points_reason VARCHAR(255),
    created_date TIMESTAMP NOT NULL,
    scanned_date TIMESTAMP NOT NULL,
    completed_date TIMESTAMP,
    modified_date TIMESTAMP,
    points_awarded_date TIMESTAMP,
    points_earned DECIMAL(10,2),
    purchase_date TIMESTAMP NOT NULL,
    items_purchased_count INTEGER NOT NULL,
    receipt_status VARCHAR(50) CHECK (receipt_status IN ('FINISHED', 'PENDING', 'REJECTED')),
    total_spent DECIMAL(10,2) NOT NULL,
    user_id VARCHAR(50),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

-- Receipt Items table
CREATE TABLE receipt_items (
    item_id VARCHAR(50) PRIMARY KEY NOT NULL,
    barcode VARCHAR(50),
    item_description VARCHAR(255) DEFAULT 'ITEM NOT FOUND',
    final_price DECIMAL(10,2) NOT NULL,
    original_price DECIMAL(10,2) NOT NULL,
    requires_review BOOLEAN DEFAULT false,
    partner_item_id VARCHAR(50),
    exclude_from_rewards BOOLEAN DEFAULT false,
    quantity_purchased INTEGER NOT NULL,
    user_flagged_barcode VARCHAR(50),
    is_user_flagged_new BOOLEAN DEFAULT false,
    user_flagged_price DECIMAL(10,2),
    user_flagged_quantity INTEGER,
    receipt_status VARCHAR(50),
    receipt_id VARCHAR(50),
    FOREIGN KEY (receipt_id) REFERENCES receipts(receipt_id),
    FOREIGN KEY (barcode) REFERENCES brands(barcode)
);

-- Create indices for frequently accessed columns
CREATE INDEX idx_receipts_user_id ON receipts(user_id);
CREATE INDEX idx_receipts_purchase_date ON receipts(purchase_date);
CREATE INDEX idx_receipts_status ON receipts(receipt_status);
CREATE INDEX idx_receipt_items_receipt_id ON receipt_items(receipt_id);
CREATE INDEX idx_receipt_items_barcode ON receipt_items(barcode);

-- Materialized Views for Analysis
CREATE MATERIALIZED VIEW mv_receipt_status_metrics AS
SELECT 
    receipt_status,
    AVG(total_spent) as avg_spend,
    SUM(items_purchased_count) as total_items_purchased,
    COUNT(*) as receipt_count
FROM receipts
WHERE receipt_status IN ('ACCEPTED', 'REJECTED')
GROUP BY receipt_status;

CREATE MATERIALIZED VIEW mv_monthly_brand_metrics AS
SELECT 
    b.name as brand_name,
    DATE_TRUNC('month', r.purchase_date) as month,
    COUNT(DISTINCT r.receipt_id) as receipt_count,
    SUM(ri.final_price * ri.quantity_purchased) as total_spend,
    COUNT(DISTINCT r.user_id) as unique_users
FROM brands b
JOIN receipt_items ri ON b.barcode = ri.barcode
JOIN receipts r ON ri.receipt_id = r.receipt_id
GROUP BY b.name, DATE_TRUNC('month', r.purchase_date);

CREATE MATERIALIZED VIEW mv_recent_user_brand_metrics AS
SELECT 
    b.name as brand_name,
    COUNT(DISTINCT r.receipt_id) as transaction_count,
    SUM(ri.final_price * ri.quantity_purchased) as total_spend
FROM brands b
JOIN receipt_items ri ON b.barcode = ri.barcode
JOIN receipts r ON ri.receipt_id = r.receipt_id
JOIN users u ON r.user_id = u.user_id
WHERE u.created_date >= CURRENT_DATE - INTERVAL '6 months'
GROUP BY b.name;