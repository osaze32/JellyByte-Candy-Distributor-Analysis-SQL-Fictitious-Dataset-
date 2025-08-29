-- ---------------------------------------------- SALES ANALYSIS ------------------------------------------------
-- Total sales
SELECT 
	ROUND(SUM(Sales), 2)  AS Total_Sales
FROM 
	candy_sales;


-- Total sales by year
 SELECT  
	DISTINCT(YEAR(Order_Date)) AS Year,
	ROUND(SUM(Sales), 2)  AS Total_Sales
FROM 
	candy_sales
GROUP BY
	YEAR(Order_Date)
ORDER BY
	Total_Sales DESC;

	
-- Average total sales by month
 SELECT  
	DISTINCT(MONTH(Order_Date)) AS Month,
	ROUND(AVG(Sales), 2)  AS Total_Sales
FROM 
	candy_sales
GROUP BY
	MONTH(Order_Date)
ORDER BY
	MONTH(Order_Date) ASC,
	Total_Sales DESC;


-- Total sales by product
SELECT
	p.Product_Name,
	ROUND(SUM(Sales), 2)  AS Total_Sales
FROM
	candy_products AS p
LEFT JOIN 
	candy_sales AS c
ON  
	p.Product_Name = c.Product_Name
GROUP BY
	p.Product_Name
ORDER BY
	Total_Sales DESC;


-- Total sales by product division
SELECT
	p.Division,
	ROUND(SUM(Sales), 2)  AS Total_Sales
FROM
	candy_products AS p
LEFT JOIN 
	candy_sales AS c
ON  
	p.Product_Name = c.Product_Name
GROUP BY
	p.Division
ORDER BY
	Total_Sales DESC;


-- Total sales by factory
SELECT
	p.Factory,
	ROUND(SUM(Sales), 2)  AS Total_Sales
FROM
	candy_products AS p
LEFT JOIN 
	candy_sales AS c
ON  
	p.Product_Name = c.Product_Name
GROUP BY
	p.Factory
ORDER BY
	Total_Sales DESC;


-- Total sales by region
SELECT
	Region,
	ROUND(SUM(Sales), 2)  AS Total_Sales
FROM
	candy_sales
GROUP BY
	Region
ORDER BY
	Total_Sales DESC;

-- Total sales by state or province
SELECT TOP 5
	State_Province,
	ROUND(SUM(Sales), 2)  AS Total_Sales
FROM
	candy_sales
GROUP BY
	State_Province
ORDER BY
	Total_Sales DESC;


	-- Total sales by shipping method
SELECT 
	Ship_Mode AS Shipping_Method,
	COUNT(*)  AS Total_Orders
FROM
	candy_sales
GROUP BY
	Ship_Mode
ORDER BY
	Total_Orders DESC;


-- ---------------------------------------------- PRODUCT ANALYSIS ----------------------------------------------------------------
-- Total demand per product
SELECT
	t.Division,
	COUNT(Order_ID) AS Total_Order,
	CASE 
		WHEN t.Division = 'Chocolate' AND  COUNT(Order_ID) > 27000 THEN  'Pass'
		WHEN t.Division = 'Sugar' AND  COUNT(Order_ID) > 15000 THEN  'Pass'
		WHEN t.Division = 'Other' AND  COUNT(Order_ID) > 3000 THEN  'Pass'
		ELSE 'Fail' END AS Outcome

FROM
	candy_targets AS t
LEFT JOIN 
	candy_sales AS c
ON  
	t.Division = c.Division

WHERE
	YEAR(c.Order_Date) = '2024'
GROUP BY
	t.Division;
