retail_sales Project

--create database
create database retail_sales

--create table
CREATE TABLE sales( 
    transactions_id INT PRIMARY key ,
    sale_date date,
    sale_time	time,
    customer_id int ,
    gender	varchar(15),
    age     int,
    category varchar(20),
    quantiy	int,
    price_per_unit float,
    cogs	float,
    total_sale float
);

--step1 cleaning data
--looking for null values

--single column checking
Select * from sales where transactions_id IS NULL

--multiple selection of columns
SELECT * FROM sales 
WHERE 
    age = 0
OR  customer_id = 0
OR  quantity = 0
OR  price_per_unit = 0
OR  cogs = 0
OR  total_sale = 0;

--delete null values
DELETE FROM sales 
WHERE 
    age = 0
OR  customer_id = 0
OR  quantity = 0
OR  price_per_unit = 0
OR  cogs = 0
OR  total_sale = 0;
	
--Data Exploration

--How many sales do we have?
SELECT COUNT(*) as total_sales FROM sales;

--How many unique customers do we have?
SELECT COUNT(DISTINCT customer_id) as customer FROM sales;

--How many categories do we have?
SELECT DISTINCT category as categories FROM sales;



--Data Analysis & Business Key Problems & Answers

--1.Write a SQL query to retrieve all columns for sales made on **'2022-11-05'**.
SELECT * from sales where sale_date='2022-11-05'

--2.Write a SQL query to retrieve all transactions where the category is **'Clothing'** and the **quantity sold is more than 10** in the month of **Nov-2022**.
SELECT  where category=

--3.Write a SQL query to calculate the **total sales (`total_sale`)** for each category.
SELECT category, sum(total_sale) FROM sales GROUP BY category

--4. Write a SQL query to find the **average age of customers** who purchased items from the **'Beauty'** category.
SELECT avg(age) FROM sales WHERE category='Beauty'

--5.Write a SQL query to find all transactions where the **`total_sale` is greater than 1000**.
SELECT * FROM sales WHERE total_sale>1000

--6.Write a SQL query to find the **total number of transactions (`transaction_id`)** made by each **gender** in each **category**.
SELECT gender, category, COUNT(transactions_id) FROM sales  GROUP BY gender, category

--7.Write a SQL query to calculate the **average sale for each month**. Find out the **best-selling month in each year**.
Select Date_format( sale_date, '%Y-%m') as month , avg(total_sale) from sales group by month

SELECT year, month, avgSale
FROM (
  SELECT year, month, avgSale,
    ROW_NUMBER() OVER (PARTITION BY year ORDER BY avgSale DESC) AS rn
  FROM (
    SELECT YEAR(sale_date) AS year, MONTH(sale_date) AS month, AVG(total_sale) AS avgSale
    FROM sales
    GROUP BY year, month
  ) AS monthly_avg
) AS ranked
WHERE rn = 1;


--8.Write a SQL query to find the **top 5 customers** based on the **highest total sales**.
Select customer_id, sum(total_sale) as totalSale from sales group by customer_id order by totalSale DESC limit 5
 
--9.Write a SQL query to find the **number of unique customers** who purchased items from **each category**.
SELECT category, COUNT(DISTINCT customer_id) from sales group by category  

--10.Write a SQL query to create **each shift** and the **number of orders**.
    **Example:**
* Morning ≤ 12
* Afternoon Between 12 & 17
* Evening > 17
