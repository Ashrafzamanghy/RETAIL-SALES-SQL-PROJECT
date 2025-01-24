# RETAIL-SALES-SQL-PROJECT

# Retail Sales Analysis SQL Project

## Project Overview

**Project Title**: Retail Sales Analysis    `

This project is designed to demonstrate SQL skills and techniques typically used by data analysts to explore, clean, and analyze retail sales data. The project involves setting up a retail sales database, performing exploratory data analysis (EDA), and answering specific business questions through SQL queries.
## Objectives

1. **Set up a retail sales database**: Create and populate a retail sales database with the provided sales data.
2. **Data Cleaning**: Identify and remove any records with missing or null values.
3. **Exploratory Data Analysis (EDA)**: Perform basic exploratory data analysis to understand the dataset.
4. **Business Analysis**: Use SQL to answer specific business questions and derive insights from the sales data.

## Project Structure

### 1. Database Setup

- **Database Creation**: The project starts by creating a database named `p1_retail_db`.
- **Table Creation**: A table named `retail_sales` is created to store the sales data. The table structure includes columns for transaction ID, sale date, sale time, customer ID, gender, age, product category, quantity sold, price per unit, cost of goods sold (COGS), and total sale amount.

```sql
CREATE DATABASE SQL_PROJECT_P1;

CREATE TABLE retail_sales
(
    transactions_id INT PRIMARY KEY,
    sale_date DATE,	
    sale_time TIME,
    customer_id INT,	
    gender VARCHAR(10),
    age INT,
    category VARCHAR(35),
    quantity INT,
    price_per_unit FLOAT,	
    cogs FLOAT,
    total_sale FLOAT
);
```

### 2. Data Exploration & Cleaning

- **Null Value Check**: Check for any null values in the dataset and delete records with missing data.
- **Delete Null Value**: Determine the total number of records in the dataset.


```sql
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
```

```sql
DELETE FROMf retail_sales
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
```




### 2.Data Analysis and insights on key problems and solution

The following SQL queries were developed to answer specific business questions:


1. **How many sales we have achieved.**:
```sql
select count(*) from retail_sales;
```

2. **No of unique customers.**:
```sql
select count(distinct customer_id) as no_of_unique_customers from retail_sales;
```

3. **No of unique category.**:
```sql
select count(distinct category) as no_of_unique_customers from retail_sales;
```

4. **Monthly total sales.**:
```sql
SELECT
    ROUND(AVG(age), 2) as avg_age
FROM retail_sales
WHERE category = 'Beauty'
```

5. **Highest monthly sales year wise.**:
```sql
select year(sale_date) as year_, monthname(sale_date) as month_of_the_year,sum(total_sale) as sum_of_monthly_sales
from retail_sales
group by year(sale_date),monthname(sale_date)
order by year_, sum_of_monthly_sales desc;
```

6. **Category wise sales.**:
```sql
select category,sum(total_sale)
from retail_sales
group by category;
```

7. **Total sale segregated by day of the week.**:
```sql
select dayname(sale_date) as Day_of_week,sum(total_sale) as sales
from retail_sales
group by Day_of_week
order by sales;

```

8. **Age wise total sale (High -Low).**:
```sql
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
```

9. **GENDER wise sales.**:
```sql
select gender,sum(total_sale)
from retail_sales
group by gender;
```

10. **Total profit by category.**:
```sql
select category,round(sum(total_sale)-sum(cogs),2) as profit
from retail_sales
group by category
order by profit;
```

11. **Highest monthly sales in year 2022,2023.**
```sql
SELECT year_,month_of_the_year,sum_of_monthly_sales,RANK_
FROM
(select year(sale_date) as year_, monthname(sale_date) as month_of_the_year,sum(total_sale)as sum_of_monthly_sales,
rank() over (partition by year(sale_date) ORDER BY sum(total_sale)desc) as RANK_
from retail_sales
group by year(sale_date), monthname(sale_date)
order by year_, sum_of_monthly_sales) AS T
WHERE RANK_ = 1;
```

12.  **Top 10 customers with highest sales**
```sql
select customer_id,sum(total_sale) as total_sales
from retail_sales
group by customer_id
order by sum(total_sale) desc
limit 20;
```
13. **Shift wise total sales (Day is divided into 4 shifts each shift starts from 12 am).**
```sql
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
```

## Findings

- **Customer Demographics**: The dataset includes customers from various age groups, with sales distributed across different categories such as Clothing and Beauty.
- **High-Value Transactions**: Several transactions had a total sale amount greater than 1000, indicating premium purchases.
- **Sales Trends**: Monthly,weekly and daily shift wise  analysis shows variations in sales, helping identify peak seasons.
- **Customer Insights**: The analysis identifies the top-spending customers and the most popular product categories.

## Reports

- **Sales Summary**: A detailed report summarizing total sales, customer demographics, and category performance.
- **Trend Analysis**: Insights into sales trends across different months and shifts.
- **Customer Insights**: Reports on top customers.
