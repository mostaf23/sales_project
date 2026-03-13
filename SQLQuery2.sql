CREATE TABLE sales_store (
transaction_id VARCHAR(15),
customer_id VARCHAR(15),
customer_name VARCHAR(30),
customer_age INT,
gender VARCHAR(15),
product_id VARCHAR(15),
product_name VARCHAR(15),
product_category VARCHAR(15),
quantiy INT,
prce FLOAT,
payment_mode VARCHAR(15),
purchase_date DATE,
time_of_purchase TIME,
status VARCHAR(15)
);

SELECT * FROM sales_store

SET DATEFORMAT dmy
BULK INSERT sales_store
FROM 'C:\Users\Elnanna\Downloads\sales.csv'
	WITH (
		FIRSTROW=2,
		FIELDTERMINATOR=',',
		ROWTERMINATOR='\n'
	);
SELECT*FROM sales_store	
--Data cleaning
--check for duplicate
--This query is used to find transaction IDs that appear more than once in the sales table
SELECT transaction_id FROM sales_store
group by  transaction_id
HAVING COUNT(transaction_id) >1






WITH CTE AS (
    SELECT *,
    ROW_NUMBER() OVER (
        PARTITION BY transaction_id
        ORDER BY transaction_id
    ) AS Row_Num
    FROM sales_store
)
DELETE FROM CTE
WHERE Row_Num=2
--Step 2 :- Correction of Headers
SELECT * FROM sales_store

EXEC sp_rename'sales_store.quantiy','quantity','COLUMN'

EXEC sp_rename'sales_store.prce','price','COLUMN'

--Step 3 :- To check Datatype

SELECT COLUMN_NAME, DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME='sales_store'

--Step 4 :- To Check Null Values 

--to check null count  of all colums dynamic

DECLARE @SQL NVARCHAR(MAX) = '';

SELECT @SQL = STRING_AGG(
    'SELECT ''' + COLUMN_NAME + ''' AS ColumnName, 
    COUNT(*) AS NullCount 
    FROM ' + QUOTENAME(TABLE_SCHEMA) + '.sales_store 
    WHERE ' + QUOTENAME(COLUMN_NAME) + ' IS NULL', 
    ' UNION ALL '
)
WITHIN GROUP (ORDER BY COLUMN_NAME)
FROM INFORMATION_SCHEMA.COLUMNS 
WHERE TABLE_NAME = 'sales_store';

-- Execute the dynamic SQL
EXEC sp_executesql @SQL;


--procesing null values
SELECT *
FROM sales_store 
WHERE transaction_id IS NULL
OR
customer_id IS NULL
OR
customer_name IS NULL
OR
customer_age IS NULL
OR
gender IS NULL
OR
product_id IS NULL
OR
product_name IS NULL
OR
product_category IS NULL
OR
quantity IS NULL
or
payment_mode is null
or
purchase_date is null
or 
status is null
or 
price is null
DELETE FROM sales_store
where transaction_id IS NULL


SELECT * FROM sales_store 
Where Customer_name='Ehsaan Ram'

UPDATE sales_store
SET customer_id='CUST9494'
WHERE transaction_id='TXN977900'

SELECT * FROM sales_store 
Where Customer_name='Damini Raju'

UPDATE sales_store
SET customer_id='CUST1401'
WHERE transaction_id='TXN985663'

SELECT * FROM sales_store 
Where Customer_id='CUST1003'

UPDATE sales_store
SET customer_name='Mahika Saini',customer_age=35,gender='Male'
WHERE transaction_id='TXN432798'


SELECT * FROM sales_store
SELECT DISTINCT gender
FROM sales_store


UPDATE sales_store
SET gender='M'
WHERE gender='Male'

UPDATE sales_store
SET gender='F'
WHERE gender='Female'

SELECT DISTINCT payment_mode
FROM sales_store

UPDATE sales_store
SET payment_mode='Credit Card'
WHERE payment_mode ='CC'



---insights questions

--🔥 1. What are the top 5 most selling products by quantity?

SELECT TOP 5 product_name, SUM(quantity) AS total_quantity_sold
FROM sales_store
WHERE status='delivered'
GROUP BY product_name

ORDER BY total_quantity_sold DESC

--Business Impact

--Helps prioritize stock and boost sales through targeted promotions


2. Which products are most frequently cancelled?

SELECT TOP 5 product_name, COUNT(*) AS total_cancelled
FROM sales_store
WHERE status='cancelled'
GROUP BY product_name
ORDER BY total_cancelled DESC

 --Business Problem: Frequent cancellations affect revenue and customer trust.
--Business Impact: Identify poor-performing products to improve quality or remove from catalog
SELECT*FROM sales_store

--🕒 3. What time of the day has the highest number of purchases?
SELECT 
		CASE 
			WHEN DATEPART(HOUR,time_of_purchase) BETWEEN 0 AND 5 THEN 'NIGHT'
			WHEN DATEPART(HOUR,time_of_purchase) BETWEEN 6 AND 11 THEN 'MORNING'
			WHEN DATEPART(HOUR,time_of_purchase) BETWEEN 12 AND 17 THEN 'AFTERNOON'
			WHEN DATEPART(HOUR,time_of_purchase) BETWEEN 18 AND 23 THEN 'EVENING'
		END AS time_of_day,
		COUNT(*) AS total_orders
	FROM sales_store
	GROUP BY 
		CASE 
			WHEN DATEPART(HOUR,time_of_purchase) BETWEEN 0 AND 5 THEN 'NIGHT'
			WHEN DATEPART(HOUR,time_of_purchase) BETWEEN 6 AND 11 THEN 'MORNING'
			WHEN DATEPART(HOUR,time_of_purchase) BETWEEN 12 AND 17 THEN 'AFTERNOON'
			WHEN DATEPART(HOUR,time_of_purchase) BETWEEN 18 AND 23 THEN 'EVENING'
		END
ORDER BY total_orders DESC

--Business Problem Solved: Find peak sales times.

--Business Impact: Optimize staffing, promotions, and server loads.




4. Who are the top 5 highest spending customers?

SELECT * FROM sales_store

SELECT TOP 5 customer_name,
	FORMAT(SUM(price*quantity),'C0','en-IN') AS total_spend
FROM sales_store 
GROUP BY customer_name
ORDER BY SUM(price*quantity) DESC

--Business Problem Solved: Identify VIP customers.

--Business Impact: Personalized offers, loyalty rewards, and retention.

-- 5- which product_categories generate the highest revenue
SELECT 
	product_category,
	FORMAT(SUM(price*quantity),'C0','en-IN') AS Revenue
FROM sales_store 
GROUP BY product_category
ORDER BY Revenue DESC
--Business Problem Solved: Identify top-performing product categories.
--Business Impact: Refine product strategy, supply chain, and promotions.
--allowing the business to invest more in high-margin or high-demand categories.


SELECT * FROM sales_store
--cancellation
SELECT product_category,
	FORMAT(COUNT(CASE WHEN status='cancelled' THEN 1 END)*100.0/COUNT(*),'N3')+' %' AS cancelled_percent
FROM sales_store 
GROUP BY product_category
ORDER BY cancelled_percent DESC

--Return
SELECT product_category,
	FORMAT(COUNT(CASE WHEN status='returned' THEN 1 END)*100.0/COUNT(*),'N3')+' %' AS returned_percent
FROM sales_store 
GROUP BY product_category
ORDER BY returned_percent DESC


--💳 7. What is the most preferred payment mode?

SELECT * FROM sales_store

SELECT payment_mode, COUNT(payment_mode) AS total_count
FROM sales_store 
GROUP BY payment_mode
ORDER BY total_count desc
--Business Problem Solved: Know which payment options customers prefer.

--Business Impact: Streamline payment processing, prioritize popular modes.


-- 8. What’s the monthly sales trend?

SELECT 
	FORMAT(purchase_date,'yyyy-MM') AS Month_Year,
	FORMAT(SUM(price*quantity),'C0','en-IN') AS total_sales,
	SUM(quantity) AS total_quantity
FROM sales_store 
GROUP BY FORMAT(purchase_date,'yyyy-MM')

