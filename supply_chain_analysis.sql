SELECT * FROM Supply_Chain_products
SELECT * FROM Supply_Chain_purchase_orders
SELECT * FROM Supply_Chain_suppliers


 --TOTAL SPEND BY SUPPLIER (Top 10 Most Expensive)
SELECT TOP 10
    Supplier_ID,
    Supplier_Name,
    COUNT(*) AS Number_of_Orders,
    SUM(Total_Cost_USD) AS Total_Spend,
    AVG(Total_Cost_USD) AS Average_Order_Cost,
    ROUND(SUM(Total_Cost_USD) / 1000, 2) AS Total_Spend_Thousands
FROM Supply_Chain_purchase_orders
GROUP BY Supplier_ID, Supplier_Name
ORDER BY Total_Spend DESC;






--SUPPLIER QUALITY ANALYSIS





SELECT
    TABLE_NAME,
    COLUMN_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME IN (
    'suppliers',
    'purchase_orders',
    'products'
)
ORDER BY TABLE_NAME, ORDINAL_POSITION;


