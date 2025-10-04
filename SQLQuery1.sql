select * from Retail_Sales;

select COUNT(*) from Retail_Sales;

select COUNT(distinct customer_id) as unique_cust from Retail_Sales;

select distinct category as unique_cat from Retail_Sales;


select * from Retail_Sales 

where 
	transactions_id is null or sale_date is null or sale_time is null
	or customer_id is null or gender is null or age is null or 
	category is null or quantiy is null or price_per_unit is null
	or cogs is null or total_sale is null;

delete from Retail_Sales 
where 
		transactions_id is null or sale_date is null or sale_time is null
	or customer_id is null or gender is null or age is null or 
	category is null or quantiy is null or price_per_unit is null




SELECT category,
sum(total_sale) as total_sales
 from Retail_Sales
 group by category

 SELECT
 AVG(age) as avg_age
 from Retail_Sales
 where category = 'Beauty'
 
 SELECT *
 from Retail_Sales
 where total_sale >= '1000'


 SELECT
 category,
 gender,
 count(transactions_id) as total_tran_id from Retail_Sales
 group by category,gender 
 order by category



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





select top 5
customer_id,
sum (total_sale) as max_sales from Retail_Sales
group by customer_id order by max_sales DESC





select category,
COUNT (distinct (customer_id) ) as count_cust from Retail_Sales
group by category order by count_cust




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


