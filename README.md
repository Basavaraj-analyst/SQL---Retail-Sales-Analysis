# SQL---Retail-Sales-Analysis



Project Overview
Project Title: Retail Sales Analysis
Level: Beginner
Database: sql_projects




This project is designed to demonstrate SQL skills and techniques typically used by data analysts to explore, clean, and analyze retail sales data. The project involves setting up a retail sales database, performing exploratory data analysis (EDA), and answering specific business questions through SQL queries. This project is ideal for those who are starting their journey in data analysis and want to build a solid foundation in SQL.





Objectives
1) Set up a retail sales database:  Create and populate a retail sales database with the provided sales data.
2) Data Cleaning: Identify and remove any records with missing or null values.
3) Exploratory Data Analysis (EDA): Perform basic exploratory data analysis to understand the dataset.
4) Business Analysis: Use SQL to answer specific business questions and derive insights from the sales data.


Project Structure:-

1. Database Setup
           Database Creation: The project starts by creating a database named sql_projects.
           Table Creation: A table named retail_sales is created to store the sales data. The table structure includes columns for transaction ID, sale              date, sale time, customer ID, gender, age, product category, quantity sold, price per unit, cost of goods sold (COGS), and total sale amount.


2. Data Exploration & Cleaning
        1) Record Count: Determine the total number of records in the dataset.
        2) Customer Count: Find out how many unique customers are in the dataset.
        3) Category Count: Identify all unique product categories in the dataset.
        4) Null Value Check: Check for any null values in the dataset and delete records with missing data.


select * from Retail_Sales;



select COUNT(*) from Retail_Sales;



select COUNT(distinct customer_id) as unique_cust from Retail_Sales;



select distinct category as unique_cat from Retail_Sales;



select * from Retail_Sales 
where 
	transactions_id is null 
        or sale_date is null 
        or sale_time is null
	or customer_id is null 
        or gender is null 
        or age is null or 
	category is null 
        or quantiy is null 
        or price_per_unit is null
	or cogs is null 
        or total_sale is null;

delete from Retail_Sales 
where 
		transactions_id is null or sale_date is null or sale_time is null
	or customer_id is null or gender is null or age is null or 
	category is null or quantiy is null or price_per_unit is null




3. Data Analysis & Findings
The following SQL queries were developed to answer specific business questions:

1) Write a SQL query to retrieve all columns for sales made on '2022-11-05:


select * from Retail_Sales
where sale_date = '2022-11-05'

2) Write a SQL query to calculate the total sales (total_sale) for each category

SELECT category,
sum(total_sale) as total_sales
 from Retail_Sales
 group by category

 3)Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category
 
 SELECT
AVG(age) as avg_age
from Retail_Sales
where category = 'Beauty'

4)Write a SQL query to find all transactions where the total_sale is greater than 1000

SELECT *
from Retail_Sales
where total_sale >= '1000'


5)Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category

SELECT
category,
gender,
count(transactions_id) as total_tran_id from Retail_Sales
group by category,gender 
order by category


6) Write a SQL query to calculate the average sale for each month. Find out bestselling month in each year

SELECT 
    YEAR(sale_date) AS sale_year,
    MONTH(sale_date) AS sale_month,
    FORMAT(sale_date, 'MMM yyyy') AS month_year,
    AVG(total_sale) AS avg_monthly_sale
FROM Retail_Sales
GROUP BY 
    YEAR(sale_date),
    MONTH(sale_date),
    FORMAT(sale_date, 'MMM yyyy')
ORDER BY 
    sale_year, sale_month;


    WITH MonthlySales AS (
    SELECT 
        YEAR(sale_date) AS sale_year,
        MONTH(sale_date) AS sale_month,
        FORMAT(sale_date, 'MMM yyyy') AS month_year,
        AVG(total_sale) AS avg_monthly_sale
    FROM Retail_Sales
    GROUP BY 
        YEAR(sale_date),
        MONTH(sale_date),
        FORMAT(sale_date, 'MMM yyyy')
)
SELECT sale_year, month_year, avg_monthly_sale
FROM (
    SELECT 
        sale_year,
        month_year,
        avg_monthly_sale,
        ROW_NUMBER() OVER (PARTITION BY sale_year ORDER BY avg_monthly_sale DESC) AS rn
    FROM MonthlySales
) AS ranked
WHERE rn = 1
ORDER BY sale_year;


7) Write a SQL query to find the top 5 customers based on the highest total sales

 select top 5
customer_id,
sum (total_sale) as max_sales from Retail_Sales
group by customer_id order by max_sales DESC

8) Write a SQL query to find the number of unique customers who purchased items from each category

select category,
COUNT (distinct (customer_id) ) as count_cust from Retail_Sales
group by category order by count_cust

9) Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)

WITH hourly_sale
AS
(
SELECT *,
    CASE
        WHEN DATEPART(HOUR, sale_time) < 12 THEN 'Morning'
        WHEN DATEPART(HOUR,  sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END as shift
FROM retail_sales
)
SELECT 
    Shift,
    COUNT(*) as total_orders    
FROM hourly_sale
GROUP BY shift

Findings
Customer Demographics: The dataset includes customers from various age groups, with sales distributed across different categories such as Clothing and Beauty.
High-Value Transactions: Several transactions had a total sale amount greater than 1000, indicating premium purchases.
Sales Trends: Monthly analysis shows variations in sales, helping identify peak seasons.
Customer Insights: The analysis identifies the top-spending customers and the most popular product categories.
Reports
Sales Summary: A detailed report summarizing total sales, customer demographics, and category performance.
Trend Analysis: Insights into sales trends across different months and shifts.
Customer Insights: Reports on top customers and unique customer counts per category.
Conclusion
This project serves as a comprehensive introduction to SQL for data analysts, covering database setup, data cleaning, exploratory data analysis, and business-driven SQL queries. The findings from this project can help drive business decisions by understanding sales patterns, customer behavior, and product performance.

How to Use
Clone the Repository: Clone this project repository from GitHub.
Set Up the Database: Run the SQL scripts provided in the database_setup.sql file to create and populate the database.
Run the Queries: Use the SQL queries provided in the analysis_queries.sql file to perform your analysis.
Explore and Modify: Feel free to modify the queries to explore different aspects of the dataset or answer additional business questions.
