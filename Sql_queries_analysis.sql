-- Create the database
CREATE DATABASE IF NOT EXISTS walmartStoreSales;

-- Create the sales table
CREATE TABLE IF NOT EXISTS sales_data (
    invoice_id VARCHAR(30) PRIMARY KEY NOT NULL,
    store_branch VARCHAR(5) NOT NULL,
    location_city VARCHAR(30) NOT NULL,
    customer_category VARCHAR(30) NOT NULL,
    customer_gender VARCHAR(30) NOT NULL,
    product_category VARCHAR(100) NOT NULL,
    price_per_unit DECIMAL(10, 2) NOT NULL,
    items_sold INT NOT NULL,
    tax_rate FLOAT(6,4) NOT NULL,
    total_amount DECIMAL(12, 4) NOT NULL,
    purchase_date DATETIME NOT NULL,
    purchase_time TIME NOT NULL,
    payment_method VARCHAR(15) NOT NULL,
    cost_of_goods_sold DECIMAL(10, 2) NOT NULL,
    gross_margin_percentage FLOAT(11,9),
    gross_income DECIMAL(12, 4),
    customer_rating FLOAT(2, 1)
);

-- Clean data and view all sales entries
SELECT * FROM sales_data;

-- Add column to classify time of the day
SELECT
    purchase_time,
    (CASE 
        WHEN purchase_time BETWEEN "00:00:00" AND "12:00:00" THEN "Morning"
        WHEN purchase_time BETWEEN "12:01:00" AND "16:00:00" THEN "Afternoon"
        ELSE "Evening"
    END) AS period_of_day
FROM sales_data;

ALTER TABLE sales_data ADD COLUMN period_of_day VARCHAR(20);

-- Disable safe mode for updates
-- Go to Edit > Preferences > SQL Editor > Disable safe mode
-- Reconnect to the database

UPDATE sales_data
SET period_of_day = 
    CASE
        WHEN purchase_time BETWEEN "00:00:00" AND "12:00:00" THEN "Morning"
        WHEN purchase_time BETWEEN "12:01:00" AND "16:00:00" THEN "Afternoon"
        ELSE "Evening"
    END;

-- Add column for day of the week
SELECT purchase_date, DAYNAME(purchase_date) AS day_of_week FROM sales_data;

ALTER TABLE sales_data ADD COLUMN day_of_week VARCHAR(10);

UPDATE sales_data
SET day_of_week = DAYNAME(purchase_date);

-- Add column for month of purchase
SELECT purchase_date, MONTHNAME(purchase_date) AS month_of_purchase FROM sales_data;

ALTER TABLE sales_data ADD COLUMN month_of_purchase VARCHAR(10);

UPDATE sales_data
SET month_of_purchase = MONTHNAME(purchase_date);

-- --------------------------------------------------------------------
-- ----------------------------- General Queries ----------------------
-- --------------------------------------------------------------------

-- Count the number of unique cities in the data
SELECT DISTINCT location_city FROM sales_data;

-- Display the branches in each city
SELECT DISTINCT location_city, store_branch FROM sales_data;

-- --------------------------------------------------------------------
-- ------------------------- Product-related Queries ------------------
-- --------------------------------------------------------------------

-- Count the number of unique product categories
SELECT DISTINCT product_category FROM sales_data;

-- Identify the top-selling product category
SELECT product_category, SUM(items_sold) AS total_sold 
FROM sales_data 
GROUP BY product_category 
ORDER BY total_sold DESC;

-- Calculate the total revenue generated each month
SELECT month_of_purchase, SUM(total_amount) AS revenue 
FROM sales_data 
GROUP BY month_of_purchase 
ORDER BY revenue;

-- Find the month with the highest cost of goods sold (COGS)
SELECT month_of_purchase, SUM(cost_of_goods_sold) AS total_cogs 
FROM sales_data 
GROUP BY month_of_purchase 
ORDER BY total_cogs DESC;

-- Identify the product category with the highest revenue
SELECT product_category, SUM(total_amount) AS total_revenue 
FROM sales_data 
GROUP BY product_category 
ORDER BY total_revenue DESC;

-- Determine the city with the highest revenue
SELECT location_city, store_branch, SUM(total_amount) AS revenue 
FROM sales_data 
GROUP BY location_city, store_branch 
ORDER BY revenue DESC;

-- Determine which product category has the highest VAT
SELECT product_category, AVG(tax_rate) AS average_tax 
FROM sales_data 
GROUP BY product_category 
ORDER BY average_tax DESC;

-- Evaluate products as "Good" or "Bad" based on average sales
SELECT product_category, 
    CASE 
        WHEN AVG(items_sold) > 6 THEN "Good" 
        ELSE "Bad" 
    END AS performance
FROM sales_data 
GROUP BY product_category;

-- Identify branches that have sold more than the average quantity
SELECT store_branch, SUM(items_sold) AS total_sold 
FROM sales_data 
GROUP BY store_branch 
HAVING total_sold > (SELECT AVG(items_sold) FROM sales_data);

-- Identify the most purchased product categories by gender
SELECT customer_gender, product_category, COUNT(*) AS total_purchases 
FROM sales_data 
GROUP BY customer_gender, product_category 
ORDER BY total_purchases DESC;

-- Calculate the average rating for each product category
SELECT product_category, ROUND(AVG(customer_rating), 2) AS average_rating 
FROM sales_data 
GROUP BY product_category 
ORDER BY average_rating DESC;

-- --------------------------------------------------------------------
-- ------------------------- Customer-related Queries -----------------
-- --------------------------------------------------------------------

-- Find all unique customer categories
SELECT DISTINCT customer_category FROM sales_data;

-- Identify unique payment methods used
SELECT DISTINCT payment_method FROM sales_data;

-- Identify the most common customer category
SELECT customer_category, COUNT(*) AS count 
FROM sales_data 
GROUP BY customer_category 
ORDER BY count DESC;

-- Determine which customer type makes the most purchases
SELECT customer_category, COUNT(*) AS total_purchases 
FROM sales_data 
GROUP BY customer_category;

-- Identify the predominant gender of customers
SELECT customer_gender, COUNT(*) AS gender_count 
FROM sales_data 
GROUP BY customer_gender 
ORDER BY gender_count DESC;

-- Examine gender distribution in branch C
SELECT customer_gender, COUNT(*) AS gender_count 
FROM sales_data 
WHERE store_branch = "C" 
GROUP BY customer_gender 
ORDER BY gender_count DESC;

-- --------------------------------------------------------------------
-- ------------------------- Sales & Time Queries ---------------------
-- --------------------------------------------------------------------

-- Check when customers give the highest ratings (by time of day)
SELECT period_of_day, AVG(customer_rating) AS avg_rating 
FROM sales_data 
GROUP BY period_of_day 
ORDER BY avg_rating DESC;

-- Compare ratings by time of day for branch A
SELECT period_of_day, AVG(customer_rating) AS avg_rating 
FROM sales_data 
WHERE store_branch = "A" 
GROUP BY period_of_day 
ORDER BY avg_rating DESC;

-- Find the day of the week with the highest average ratings
SELECT day_of_week, AVG(customer_rating) AS avg_rating 
FROM sales_data 
GROUP BY day_of_week 
ORDER BY avg_rating DESC;

-- Determine sales volume in different periods on Sundays
SELECT period_of_day, COUNT(*) AS total_sales 
FROM sales_data 
WHERE day_of_week = "Sunday" 
GROUP BY period_of_day 
ORDER BY total_sales DESC;

-- Identify which customer type generates the most revenue
SELECT customer_category, SUM(total_amount) AS total_revenue 
FROM sales_data 
GROUP BY customer_category 
ORDER BY total_revenue DESC;

-- Find the city with the highest VAT percentage
SELECT location_city, ROUND(AVG(tax_rate), 2) AS avg_tax_rate 
FROM sales_data 
GROUP BY location_city 
ORDER BY avg_tax_rate DESC;

-- Find which customer category contributes the most VAT
SELECT customer_category, AVG(tax_rate) AS avg_tax_rate 
FROM sales_data 
GROUP BY customer_category 
ORDER BY avg_tax_rate DESC;
