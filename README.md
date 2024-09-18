# 📊 Walmart Sales Data Analysis

## 🚀 Project Overview

This project dives into Walmart's sales data to identify top-performing branches and products, analyze sales trends, and uncover customer behavior patterns. The objective is to generate insights that can be used to refine and optimize Walmart’s sales strategies. The dataset was sourced from the [Kaggle Walmart Sales Forecasting Competition](https://www.kaggle.com/c/walmart-recruiting-store-sales-forecasting).


## 🎯 Objectives

1. 🛒 **Product Analysis**: Understand performance by product line and identify areas for improvement.
2. 💰 **Sales Trends**: Track sales patterns to evaluate the success of current strategies and discover opportunities for optimization.
3. 👥 **Customer Insights**: Segment customers by type and behavior to refine marketing efforts.

## 📝 Dataset Description

The dataset consists of transactions across three Walmart branches located in Mandalay, Yangon, and Naypyitaw. It contains 17 columns and 1000 rows:

| Column                  | Description                             | Data Type      |
|-------------------------|-----------------------------------------|----------------|
| invoice_id              | Sales invoice identifier                | VARCHAR(30)    |
| branch                  | Branch where sales occurred             | VARCHAR(5)     |
| city                    | City of the branch                      | VARCHAR(30)    |
| customer_type           | Type of customer                        | VARCHAR(30)    |
| gender                  | Gender of customer                      | VARCHAR(10)    |
| product_line            | Product category                        | VARCHAR(100)   |
| unit_price              | Price of product                        | DECIMAL(10, 2) |
| quantity                | Number of products sold                 | INT            |
| VAT                     | Tax applied to the purchase             | FLOAT(6, 4)    |
| total                   | Total amount for the purchase           | DECIMAL(10, 2) |
| date                    | Date of transaction                     | DATE           |
| time                    | Time of transaction                     | TIMESTAMP      |
| payment_method          | Payment method                          | VARCHAR(15)    |
| cogs                    | Cost of Goods Sold                      | DECIMAL(10, 2) |
| gross_margin_percentage | Gross margin percentage                 | FLOAT(11, 9)   |
| gross_income            | Gross Income                            | DECIMAL(10, 2) |
| rating                  | Customer rating                         | FLOAT(2, 1)    |

## 🔍 Analysis Goals

### 🛍️ Product Analysis
- Identify the top-performing product lines and underperformers.
- Analyze which products generate the most revenue.

### 📈 Sales Trends
- Explore trends by time of day, week, and month.
- Determine the impact of holidays and markdowns on sales.

### 👤 Customer Insights
- Identify customer segments with the highest spending.
- Explore differences in purchasing behavior by gender and customer type.

## 🛠️ Methodology

1. **Data Preparation:**
   - Create and clean the database to address any missing or NULL values.
   - Add new columns:
     - `time_of_day`: Categorizes transactions into morning, afternoon, or evening.
     - `day_name` & `month_name`: Extracts the day of the week and month for more granular analysis.

2. **Exploratory Data Analysis (EDA):**
   - Perform EDA to address the business questions and identify trends.

## ❓ Business Questions to Answer

### 💡 Generic Questions

1. How many unique cities are present in the dataset?
2. What are the corresponding cities for each branch?

### 🛒 Product Insights

1. Which product line has the highest sales?
2. What is the most common payment method?
3. Which month had the highest sales and COGS?
4. What product line generates the most revenue?
5. Which city produces the highest revenue?
6. Which product line contributes the most VAT?
7. Are there product lines performing better than average?
8. Which branch exceeds the average sales volume?
9. Which product line is most popular by gender?

### 📈 Sales Trends

1. Number of sales during different times of day and week.
2. Which customer type brings the highest revenue?
3. Which city has the highest VAT percentage?
4. Which customer type pays the most in VAT?

### 👥 Customer Insights

1. How many unique customer types exist?
2. How many payment methods are used?
3. What is the most common customer type?
4. Which customer type purchases the most?
5. What is the gender distribution across branches?
6. Which part of the day do customers give the highest ratings?
7. Which day of the week has the best average rating?

## 💵 Revenue & Profit Calculations

- **COGS (Cost of Goods Sold):** 
  \[
  COGS = \text{Unit Price} \times \text{Quantity}
  \]
  
- **VAT (Value Added Tax):** 
  \[
  VAT = 5\% \times COGS
  \]
  
- **Total Sales:** 
  \[
  \text{Total Sales} = VAT + COGS
  \]
  
- **Gross Profit:** 
  \[
  \text{Gross Profit} = \text{Total Sales} - COGS
  \]

- **Gross Margin:** 
  \[
  \text{Gross Margin} = \frac{\text{Gross Profit}}{\text{Total Sales}}
  \]

### Example:

- **Unit Price:** 45.79, **Quantity:** 7
- **COGS:** $45.79 \times 7 = 320.53$
- **VAT:** $5\% \times 320.53 = 16.03$
- **Total Sales:** $320.53 + 16.03 = 336.56$
- **Gross Margin:** $\frac{16.03}{336.56} \approx 4.76\%$

