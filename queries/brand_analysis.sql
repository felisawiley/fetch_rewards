-- What are the top 5 brands by receipts scanned for most recent month?

WITH RecentReceipts AS (
    SELECT 
        DATE_TRUNC('month', scanned_date) AS receipt_month,
        brand_name,
        COUNT(*) AS receipt_count
    FROM receipts r
    JOIN receipt_items ri ON r.receipt_id = ri.receipt_id
    JOIN brands b ON ri.barcode = b.barcode
    WHERE scanned_date >= DATE_TRUNC('month', CURRENT_DATE) - INTERVAL '1 month'
    AND scanned_date < DATE_TRUNC('month', CURRENT_DATE)
    GROUP BY receipt_month, brand_name
)
SELECT brand_name, receipt_count
FROM RecentReceipts
ORDER BY receipt_count DESC
LIMIT 5;
