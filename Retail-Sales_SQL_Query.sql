-- This is SQL Retail Sales Project

--create TABLE

CREATE TABLE RetailSales
        (
            transactions_id INT PRIMARY KEY,
            sale_date DATE,
            sale_time TIME,
            customer_id INT,
            gender VARCHAR(15),
            age INT,
            category VARCHAR(15),
            quantiy INT,
            price_per_unit FLOAT,
            cogs FLOAT,
            total_sale FLOAT

);


SELECT * FROM RetailSales
LIMIT 10

SELECT COUNT(*) FROM RetailSales


SELECT * FROM RetailSales
WHERE  transactions_id IS NULL

SELECT * FROM RetailSales
WHERE  sale_date IS NULL

SELECT * FROM RetailSales
WHERE  sale_time IS NULL

--simpler way of writing it 
SELECT * FROM RetailSales
WHERE 
     transactions_id IS NULL
	 OR
	 sale_date IS NULL
	 OR
	 sale_time IS NULL
     OR
	 gender IS NULL
	 OR
	 category IS NULL
	 OR
	 quantiy IS NULL
     OR 
	 cogs IS NULL
	 OR
	 total_sale IS NULL

--Deleting rows with no information
--DATA CLEANING
DELETE FROM RetailSales
WHERE 
     transactions_id IS NULL
	 OR
	 sale_date IS NULL
	 OR
	 sale_time IS NULL
     OR
	 gender IS NULL
	 OR
	 category IS NULL
	 OR
	 quantiy IS NULL
     OR 
	 cogs IS NULL
	 OR
	 total_sale IS NULL
--NO NULL RECORDS AFTER THIS
--DATA EXPLORATION

--HOW MANY SALES WE HAVE

SELECT COUNT(*) as total_sale FROM RetailSales

--HOW MANY CUSTOMERS WE HAVE
--ND add DISTINCT to get unique customers

SELECT COUNT(DISTINCT customer_id) as total_sale FROM RetailSales

--HOW MANY UNIQUE CATEGORIES

SELECT COUNT(DISTINCT category) as total_sale FROM RetailSales


--output the unique catergories
SELECT DISTINCT category FROM RetailSales

--DATA ANALYSIS

-- 1 WRITE AN  SQL QUERY TO RETRIVE ALL COLUMNS FOR SALES MADE ON '2022-11-05'
SELECT * FROM RetailSales
WHERE sale_date = '2022-11-05';

--2 WRITE AN SQL QUERY TP RETRIVE ALL TRANSACTIONS WHERE THE CATEGORY IT THE CLOTHING AND THE QUALITY SOLD IS MORE THAN 4 IN THE MONTH OF NOV-2022
SELECT * FROM RetailSales WHERE category = 'Clothing' 
AND TO_CHAR(sale_date, 'YYYY-MM' ) = '2022-11'
AND quantiy >= 4


--WRITE AN SQL QUERY THAT CALCULATES THE TOTAL SALES FOR EACG CATEGPRY
SELECT category, sum(total_sale) as net_sale, COUNT(*) as total_orders FROM RetailSales GROUP BY 1

--WRITE A SL QY=UERY TO FIND THE AVERAGE AGE OF CUSTOMERS WHO PURCHASED ITEM FROM THE 'Beauty' category
SELECT 
ROUND(AVG(age),2) as  AverageAge
FROM RetailSales
WHERE category = 'Beauty'


--WRITE AN SQL QUERY TO FIND ALL TRANSACTIONS WHERE THE TOTAL SALES IS GREATER THAN 1000

SELECT * FROM RetailSales
WHERE total_sale > 1000


--WRITE AN  SQL QUERY TO FIND THE TOTAL NUMBER OF TRANSCATIONS MADE BY EACH GENDER IN EACH CATEGORY

SELECT 
category,
gender,
COUNT (*) as toatl_trans
FROM RetailSales
GROUP 
BY
category,
gender
ORDER BY 1


--WRITE AN SQL  QUERY TO CALCULATE THE AVERAGE SALE FOR EACH MONTH.FIND OUT THE BEST SELLING MONTH IN EACH YEAR
--MOST COMMON Q ASKED IN INTERVIEW
SELECT * FROM
(
SELECT 
EXTRACT(YEAR FROM sale_date) as year,
EXTRACT(MONTH FROM sale_date) as month,
AVG(total_sale) as avg_sale ,
RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC) as rank
FROM RetailSales
GROUP  BY 1, 2
)
as t1
WHERE rank = 1
--ORDER  BY 1, 3 DESC



--WRITE AN SQL QUERY TO FIND THE TOP 5 CUSTOMERS BASED ON THE HIGHEST TOTAL SALES

SELECT 
customer_id,
SUM(total_sale) as total_sales
FROM RetailSales
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5

--WRITE AN SQL QUERY TO FIND THE NUMBER OF UNIQUE CUSTOMERS WHO PURCHASED FROM EACH CATEGORY
SELECT 
category,
COUNT(DISTINCT customer_id) as cnt_unique_cs

FROM RetailSales
GROUP BY category

--WRITE A SQL QUERY TO CREATE A SHIFT AND NUMBER OF ORDER 
WITH HourlySales
AS
(
SELECT *,
   CASE
      WHEN EXTRACT (HOUR FROM sale_time) < 12 THEN 'Morning'
      WHEN EXTRACT (HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
      ELSE 'Evening'
   END as shift 
FROM RetailSales
)
SELECT
shift,
COUNT(*) as total_orders
FROM HourlySales
GROUP BY shift

--SELECT EXTRACT (HOUR FROM CURRENT_TIME)



--END OF PROJECT