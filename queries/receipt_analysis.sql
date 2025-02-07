--2. When considering total number of items purchased from receipts with rewardsReceiptStatus of Accepted or Rejected, which is greater?

SELECT 
    r.receipt_status,
    SUM(ri.quantity_purchased) AS total_items_purchased
FROM receipts r
JOIN receipt_items ri ON r.receipt_id = ri.receipt_id
WHERE r.receipt_status IN ('Accepted', 'Rejected')
GROUP BY r.receipt_status
ORDER BY total_items_purchased DESC;
