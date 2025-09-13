drop table if exists retail_sale_2;
CREATE TABLE retail_sale_2
(

    transactions_id INT primary key,		     						
    sale_date date,
    sale_time time,
    customer_id int,
    gender varchar(10),
    age int, 
    category varchar(25),
    quantity int,
    price_per_unit float,
    cogs float,
    total_sale float
);

select count(*) from retail_sale_2;

select * from retail_sale_2
where
     transactions_id is null
	 or
	 sale_date is null
	 or
	 sale_time is null
	 or
	 customer_id is null
	 or
	 gender is null
     or
	 age is null
	 or
	 category is null
	 or
	 quantity is null
	 or
	 price_per_unit is null
	 or
	 cogs is null
	 or
	 total_sale is null;

	 
--delete all the null value
delete  from retail_sale_2
where
      transactions_id is null
	 or
	 sale_date is null
	 or
	 sale_time is null
	 or
	 customer_id is null
	 or
	 gender is null
     or
	 age is null
	 or
	 category is null
	 or
	 quantity is null
	 or
	 price_per_unit is null
	 or
	 cogs is null
	 or
	 total_sale is null;





-- Data Analysis & Business Key Problems & Answers

-- My Analysis & Findings
-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022
-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)



-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
select * from retail_sale_2
where sale_date =  '2022-11-05';

-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 2 in the month of Nov-2022
select * from retail_sale_2
where
     category = 'Clothing'
	 and
	 quantity >= 2
	 and
	 to_char(sale_date, 'yyyy-mm') = '2022-11'

-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
SELECT 
    category,
    SUM(total_sale) AS netsale
FROM retail_sale_2
GROUP BY category;

-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
select
round(AVG(age), 2) as avg_age 
from retail_sale_2
where category = 'Beauty';

-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
select * from retail_sale_2
where total_sale > 1000


-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
select
      gender,
	  category,
	  count(*) as transactions
	  from retail_sale_2 
	  group by
	  gender,
	  category

-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year

SELECT *
FROM (
    SELECT 
        EXTRACT(YEAR FROM sale_date) AS year,
        EXTRACT(MONTH FROM sale_date) AS month,
        AVG(total_sale) AS avg_sale,
        RANK() OVER(
            PARTITION BY EXTRACT(YEAR FROM sale_date) 
            ORDER BY AVG(total_sale) DESC
        ) AS rank
    FROM retail_sale_2
    GROUP BY 1, 2
) AS t1
WHERE rank = 1;

-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 

select customer_id,sum(total_sale) as total_sale from retail_sale_2
group by (customer_id)
order by (total_sale) desc
limit 5

-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
	  
	select
	   
	     category,
		 count(distinct customer_id)
	from retail_sale_2  
        group by category

		-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)
     with hourly_sale
	 as(
       select *,
		 case
		     when extract(hour from sale_time) < 12 then 'morning'
	
			 when extract(hour from sale_time) between 12 and 17 then 'afternoon'

			 else 'evening'
			 
			 end as shift
		from retail_sale_2
        )
       select shift,count(*) as total_order from hourly_sale
         group by shift       

--end of project








		

