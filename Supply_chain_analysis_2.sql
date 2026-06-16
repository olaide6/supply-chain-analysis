

 --TOP 10 SUPPLIERS BY SPEND + SUPPLIER DETAILS
SELECT TOP 10
    s.Supplier_ID,
    s.Supplier_Name,
    s.Country,
    s.Quality_Score_1_10,
    s.Status,
    COUNT(p.PO_ID) AS Number_of_Orders,
    SUM(p.Total_Cost_USD) AS Total_Spend,
    ROUND(AVG(p.Total_Cost_USD), 2) AS Average_Order_Cost,
    ROUND(SUM(p.Total_Cost_USD) / 1000, 2) AS Total_Spend_Thousands
FROM Supply_Chain_purchase_orders p
INNER JOIN Supply_Chain_suppliers s 
ON p.Supplier_ID = s.Supplier_ID
GROUP BY s.Supplier_ID, s.Supplier_Name, s.Country, s.Quality_Score_1_10, s.Status
ORDER BY Total_Spend DESC;


--SUPPLIER QUALITY ANALYSIS + COUNTRY COMPARISON
SELECT 
    s.Country,
    s.Supplier_ID,
    s.Supplier_Name,
    s.Quality_Score_1_10,
    COUNT(p.PO_ID) AS Total_Orders,
    SUM(p.Defects_Found) AS Total_Defects,
    ROUND(AVG(p.Defect_Rate_Percent), 2) AS Average_Defect_Rate,
    CASE 
        WHEN AVG(p.Defect_Rate_Percent) > 10 THEN 'High Risk'
        WHEN AVG(p.Defect_Rate_Percent) > 5 THEN 'Medium Risk'
        ELSE 'Good'
    END AS Quality_Status
FROM Supply_Chain_purchase_orders p
INNER JOIN Supply_Chain_suppliers s 
ON p.Supplier_ID = s.Supplier_ID
GROUP BY s.Country, s.Supplier_ID, s.Supplier_Name, s.Quality_Score_1_10
HAVING AVG(p.Defect_Rate_Percent) > 0
ORDER BY s.Country, Average_Defect_Rate DESC;



-- ON-TIME DELIVERY BY SUPPLIER + LEAD TIME COMPARISON
SELECT 
    s.Supplier_ID,
    s.Supplier_Name,
    s.Lead_Time_Days,
    s.Country,
    COUNT(p.PO_ID) AS Total_Orders,
    SUM(CASE WHEN p.On_Time_Delivery = 1 THEN 1 ELSE 0 END) AS On_Time_Orders,
    SUM(CASE WHEN p.On_Time_Delivery = 0 THEN 1 ELSE 0 END) AS Late_Orders,
    ROUND(
        (SUM(CASE WHEN p.On_Time_Delivery = 1 THEN 1 ELSE 0 END) * 100.0) 
        / COUNT(p.PO_ID), 
        2
    ) AS On_Time_Delivery_Percent,
    CASE 
        WHEN (SUM(CASE WHEN p.On_Time_Delivery = 1 THEN 1 ELSE 0 END) * 100.0) / COUNT(p.PO_ID) >= 90 THEN 'Reliable'
        WHEN (SUM(CASE WHEN p.On_Time_Delivery = 1 THEN 1 ELSE 0 END) * 100.0) / COUNT(p.PO_ID) >= 80 THEN 'Acceptable'
        ELSE 'Needs Improvement'
    END AS Reliability_Status
FROM Supply_Chain_purchase_orders p
INNER JOIN Supply_Chain_suppliers s ON p.Supplier_ID = s.Supplier_ID
GROUP BY s.Supplier_ID, s.Supplier_Name, s.Lead_Time_Days, s.Country
ORDER BY On_Time_Delivery_Percent DESC;

-- PRODUCT CATEGORY SPEND + SUPPLIER QUALITY ANALYSIS

SELECT 
    pr.Category,
    pr.Product_ID,
    pr.Product_Name,
    s.Supplier_Name,
    s.Quality_Score_1_10,
    COUNT(p.PO_ID) AS Number_of_Orders,
    SUM(p.Total_Cost_USD) AS Total_Spend,
    ROUND(AVG(p.Total_Cost_USD), 2) AS Average_Order_Cost,
    ROUND(AVG(p.Defect_Rate_Percent), 2) AS Average_Defect_Rate,
    ROUND(SUM(p.Total_Cost_USD) / 1000, 2) AS Total_Spend_Thousands
FROM Supply_Chain_purchase_orders p
INNER JOIN Supply_Chain_suppliers s ON p.Supplier_ID = s.Supplier_ID
INNER JOIN Supply_Chain_products pr ON p.Product_ID = pr.Product_ID
GROUP BY pr.Category, pr.Product_ID, pr.Product_Name, s.Supplier_Name, s.Quality_Score_1_10
ORDER BY Total_Spend DESC;


--SUPPLIER RISK ASSESSMENT
SELECT 
    s.Supplier_ID,
    s.Supplier_Name,
    s.Country,
    s.Status,
    COUNT(p.PO_ID) AS Total_Orders,
    ROUND(SUM(p.Total_Cost_USD) / 1000, 2) AS Total_Spend_K,
    ROUND(AVG(p.Defect_Rate_Percent), 2) AS Avg_Defect_Rate,
    ROUND(
        (SUM(CASE WHEN p.On_Time_Delivery = 1 THEN 1 ELSE 0 END) * 100.0) 
        / COUNT(p.PO_ID), 
        2
    ) AS On_Time_Percent,
    CASE 
        WHEN AVG(p.Defect_Rate_Percent) <= 5 
             AND (SUM(CASE WHEN p.On_Time_Delivery = 1 THEN 1 ELSE 0 END) * 100.0) / COUNT(p.PO_ID) >= 85
        THEN 'Preferred Supplier'
        WHEN AVG(p.Defect_Rate_Percent) > 10 
             OR (SUM(CASE WHEN p.On_Time_Delivery = 1 THEN 1 ELSE 0 END) * 100.0) / COUNT(p.PO_ID) < 75
        THEN 'At Risk'
        ELSE 'Acceptable'
    END AS Supplier_Status
FROM Supply_Chain_purchase_orders p
INNER JOIN Supply_Chain_suppliers s ON p.Supplier_ID = s.Supplier_ID
GROUP BY s.Supplier_ID, s.Supplier_Name, s.Country, s.Status
ORDER BY Supplier_Status, Total_Spend_K DESC;

 --PAYMENT STATUS + SUPPLIER PERFORMANCE ANALYSIS
SELECT 
    p.Payment_Status,
    s.Supplier_ID,
    s.Supplier_Name,
    s.Country,
    COUNT(p.PO_ID) AS Number_of_Orders,
    SUM(p.Total_Cost_USD) AS Total_Amount,
    ROUND(AVG(p.Total_Cost_USD), 2) AS Average_Order_Cost,
    ROUND(AVG(p.Defect_Rate_Percent), 2) AS Avg_Defect_Rate,
    ROUND(
        (SUM(CASE WHEN p.On_Time_Delivery = 1 THEN 1 ELSE 0 END) * 100.0) 
        / COUNT(p.PO_ID), 
        2
    ) AS On_Time_Percent
FROM Supply_Chain_purchase_orders AS p
INNER JOIN Supply_Chain_suppliers AS s ON p.Supplier_ID = s.Supplier_ID
GROUP BY p.Payment_Status, s.Supplier_ID, s.Supplier_Name, s.Country
ORDER BY Payment_Status, Total_Amount DESC;

-- QUERY 7: COST SAVINGS OPPORTUNITY (Top 5 with Product Details)
-- Identify top suppliers for negotiation + their product mix
SELECT TOP 5
    s.Supplier_ID,
    s.Supplier_Name,
    s.Country,
    s.Payment_Terms_Days,
    COUNT(DISTINCT p.PO_ID) AS Number_of_Orders,
    COUNT(DISTINCT pr.Product_ID) AS Different_Products,
    SUM(p.Total_Cost_USD) AS Total_Spend,
    ROUND(AVG(p.Unit_Cost_USD), 2) AS Average_Unit_Cost,
    ROUND(SUM(p.Total_Cost_USD) / 1000, 2) AS Total_Spend_K,
    ROUND(
        (SUM(p.Total_Cost_USD) / (SELECT SUM(Total_Cost_USD) FROM Supply_Chain_purchase_orders)) * 100,
        2
    ) AS Percent_of_Total_Spend,
    ROUND(AVG(p.Defect_Rate_Percent), 2) AS Avg_Defect_Rate,
    'Negotiate for 5-10% discount' AS Opportunity
FROM Supply_Chain_purchase_orders p
INNER JOIN Supply_Chain_suppliers s ON p.Supplier_ID = s.Supplier_ID
INNER JOIN Supply_Chain_products pr ON p.Product_ID = pr.Product_ID
GROUP BY s.Supplier_ID, s.Supplier_Name, s.Country, s.Payment_Terms_Days
ORDER BY Total_Spend DESC;


--SUPPLIER PERFORMANCE SCORECARD
---Create comprehensive supplier scorecard with all metrics
SELECT 
    s.Supplier_ID,
    s.Supplier_Name,
    s.Country,
    s.Quality_Score_1_10 AS Supplier_Quality_Rating,
    s.Lead_Time_Days,
    COUNT(p.PO_ID) AS Orders,
    ROUND(SUM(p.Total_Cost_USD) / 1000, 2) AS Spend_K,
    ROUND(AVG(p.Unit_Cost_USD), 2) AS Avg_Unit_Cost,
    ROUND(AVG(p.Defect_Rate_Percent), 2) AS Defect_Rate,
    ROUND(
        (SUM(CASE WHEN p.On_Time_Delivery = 1 THEN 1 ELSE 0 END) * 100.0) 
        / COUNT(p.PO_ID), 
        2
    ) AS On_Time_Percent,
    COUNT(DISTINCT pr.Category) AS Product_Categories,
    CASE 
        WHEN AVG(p.Defect_Rate_Percent) <= 5 
             AND (SUM(CASE WHEN p.On_Time_Delivery = 1 THEN 1 ELSE 0 END) * 100.0) / COUNT(p.PO_ID) >= 85 
        THEN '★★★★★ Excellent'
        WHEN AVG(p.Defect_Rate_Percent) <= 8 
             AND (SUM(CASE WHEN p.On_Time_Delivery = 1 THEN 1 ELSE 0 END) * 100.0) / COUNT(p.PO_ID) >= 80 
        THEN '★★★★ Good'
        WHEN AVG(p.Defect_Rate_Percent) > 10 
             OR (SUM(CASE WHEN p.On_Time_Delivery = 1 THEN 1 ELSE 0 END) * 100.0) / COUNT(p.PO_ID) < 75
        THEN '★★ Needs Improvement'
        ELSE '★★★ Acceptable'
    END AS Overall_Rating
FROM Supply_Chain_purchase_orders p
INNER JOIN Supply_Chain_suppliers s ON p.Supplier_ID = s.Supplier_ID
INNER JOIN Supply_Chain_products pr ON p.Product_ID = pr.Product_ID
GROUP BY s.Supplier_ID, s.Supplier_Name, s.Country, s.Quality_Score_1_10, s.Lead_Time_Days
ORDER BY Spend_K DESC;