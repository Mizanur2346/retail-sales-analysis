/*
  Project 1: Sales & Profitability Analysis
  Database: Oracle FreeSQL    Table: sales

  Data check (should match the Excel PivotTables):
    Rows:          600
    Total revenue: 136,722.05 GBP
    Total profit:   56,016.85 GBP
    Overall margin: 40.97 %

  Data cleaning applied before loading (see CleaningLog in the Excel file):
    - "london" corrected to "London"
    - " Wireless Mouse " trimmed
    - 1 blank PaymentMethod set to "Unknown"
    - OrderDate converted from text to real dates
*/

-- Check: row count and grand totals
SELECT COUNT(*)         AS row_count,
       SUM(revenue_gbp) AS total_revenue,
       SUM(profit_gbp)  AS total_profit
FROM sales;

-- Q1: Revenue, profit and margin by region
SELECT region,
       SUM(revenue_gbp) AS total_revenue,
       SUM(profit_gbp)  AS total_profit,
       ROUND(SUM(profit_gbp) / SUM(revenue_gbp) * 100, 2) AS margin_pct
FROM sales
GROUP BY region
ORDER BY total_profit DESC;

-- Q2: Revenue, profit and margin by discount level
SELECT discount_pct,
       COUNT(*) AS orders,
       SUM(revenue_gbp) AS total_revenue,
       SUM(profit_gbp)  AS total_profit,
       ROUND(SUM(profit_gbp) / SUM(revenue_gbp) * 100, 2) AS margin_pct
FROM sales
GROUP BY discount_pct
ORDER BY discount_pct;

-- Q3: Five products with the lowest margin
SELECT product,
       SUM(revenue_gbp) AS total_revenue,
       SUM(profit_gbp)  AS total_profit,
       ROUND(SUM(profit_gbp) / SUM(revenue_gbp) * 100, 2) AS margin_pct
FROM sales
GROUP BY product
ORDER BY margin_pct ASC
FETCH FIRST 5 ROWS ONLY;

-- Q4: Revenue, profit and margin by category
SELECT category,
       SUM(revenue_gbp) AS total_revenue,
       SUM(profit_gbp)  AS total_profit,
       ROUND(SUM(profit_gbp) / SUM(revenue_gbp) * 100, 2) AS margin_pct
FROM sales
GROUP BY category
ORDER BY total_profit DESC;

-- Q5: Revenue, profit and margin by month
SELECT month_num,
       month_name,
       SUM(revenue_gbp) AS total_revenue,
       SUM(profit_gbp)  AS total_profit,
       ROUND(SUM(profit_gbp) / SUM(revenue_gbp) * 100, 2) AS margin_pct
FROM sales
GROUP BY month_num, month_name
ORDER BY month_num;

-- Q6: Rank products by profit within each category
SELECT category,
       product,
       SUM(profit_gbp) AS total_profit,
       ROUND(SUM(profit_gbp) / SUM(revenue_gbp) * 100, 2) AS margin_pct,
       RANK() OVER (PARTITION BY category ORDER BY SUM(profit_gbp) DESC) AS profit_rank
FROM sales
GROUP BY category, product
ORDER BY category, profit_rank;

-- Q7: Orders with a profit margin below 30% (expected: 11 rows)
SELECT order_id,
       product,
       discount_pct,
       revenue_gbp,
       profit_gbp,
       ROUND(profit_gbp / revenue_gbp * 100, 2) AS margin_pct
FROM sales
WHERE profit_gbp / revenue_gbp < 0.30
ORDER BY margin_pct;
