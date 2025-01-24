CREATE database SQL_PROJECT_P1;
CREATE table Retail_Sales (
	transactions_id int PRIMARY KEY,
	sale_date date,
	sale_time time,
	customer_id int,
	gender varchar(15),	
    age int,
	category varchar(15),
	quantiy int,
	price_per_unit float,
	cogs float,
	total_sale float
    );



select count(*) from retail_sales
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
     quantiy is null
     or
     price_per_unit is null
     or 
     cogs is null
     or 
     total_sale is null;
     

-- How many sales we have achieved--

select count(*) from retail_sales;

-- No of unique customers--

select count(distinct customer_id) as no_of_unique_customers from retail_sales;

-- No of unique category --

select count(distinct category) as no_of_unique_customers from retail_sales;

-- Data Analysis and insights on key problems and solution --

-- Monthly total sales --

select year(sale_date) as year_, monthname(sale_date) as month_of_the_year,sum(total_sale) as sum_of_monthly_sales
from retail_sales
group by year(sale_date),monthname(sale_date)
order by year_, month_of_the_year;

-- Highest monthly sales year wise --

select year(sale_date) as year_, monthname(sale_date) as month_of_the_year,sum(total_sale) as sum_of_monthly_sales
from retail_sales
group by year(sale_date),monthname(sale_date)
order by year_, sum_of_monthly_sales desc;


-- Category wise sales --

select category,sum(total_sale)
from retail_sales
group by category;


-- Total sale segregated by day of the week --

select dayname(sale_date) as Day_of_week,sum(total_sale) as sales
from retail_sales
group by Day_of_week
order by sales;

-- Age wise total sale (High -Low) --

select
      case
		  when age between 1 and 10 then '1-10'
          when age between 11 and 20 then '11-20'
          when age between 21 and 30 then '21-30'
          when age between 31 and 40 then '31-40'
          when age between 41 and 50 then '41-50'
          when age between 51 and 60 then '51-60'
          when age>60 then 'Senior-Citizen'
	  end as AGE_GROUP,
       sum(total_Sale) as Total_sales
from retail_sales
group by AGE_GROUP
order by Total_sales desc;


-- GENDER wise sales --

select gender,sum(total_sale)
from retail_sales
group by gender;

-- Total profit by category --

select category,round(sum(total_sale)-sum(cogs),2) as PROFIT
from retail_sales
group by category
order by PROFIT;

-- Highest monthly sales in year 2022,2023 --

SELECT year_,month_of_the_year,sum_of_monthly_sales,RANK_
FROM
(select year(sale_date) as year_, monthname(sale_date) as month_of_the_year,sum(total_sale)as sum_of_monthly_sales,
rank() over (partition by year(sale_date) ORDER BY sum(total_sale)desc) as RANK_
from retail_sales
group by year(sale_date), monthname(sale_date)
order by year_, sum_of_monthly_sales) AS T
WHERE RANK_ = 1;


--  Top 10 customers with highest sales --

select customer_id,sum(total_sale) as total_sales
from retail_sales
group by customer_id
order by sum(total_sale) desc
limit 20;


----  Shift wise total sales (Day is divided into 4 shifts each shift starts from 12 am) ----

select 
      case
		  when hour(sale_time) between 0 and 5 then 'midnight'
          when hour(sale_time) between 6 and 11 then 'morning'
          when hour(sale_time) between 12 and 17 then 'evening'
          when hour(sale_time) between 18 and 23 then 'night'
	 end as shifts,
		sum(total_sale) as Total_sales
from retail_sales
group by shifts
order by sum(total_sale) desc;
