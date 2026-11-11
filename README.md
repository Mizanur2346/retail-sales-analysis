# Retail Sales & Profitability Analysis

An end-to-end analysis of 600 retail sales transactions (2025) using **Excel, SQL (Oracle) and Power BI**. The goal was to find which products, regions and months perform best, where profit is low, and what the business could improve.

![Dashboard](images/dashboard_overview.png)

## Business questions

1. Which products, regions and months perform best?
2. Where are profit margins low?
3. Do discounts affect profitability?

## Tools used

| Tool | Used for |
|---|---|
| Excel | Data cleaning, helper columns, PivotTables |
| SQL (Oracle FreeSQL) | Re-answering the questions with queries and checking totals |
| Power BI Desktop | Interactive dashboard with KPI cards, charts and slicers |

## Dataset

600 orders with these fields: OrderID, OrderDate, Region, Category, Product, Quantity, UnitPrice, DiscountPct, UnitCost, Revenue, Cost, Profit, PaymentMethod (all money in GBP).

## Data cleaning

| Issue | Rows | Fix |
|---|---|---|
| Region `london` in lower case | 1 | Standardised to `London` |
| Product ` Wireless Mouse ` with extra spaces | 1 | Trimmed |
| Missing PaymentMethod | 1 | Set to `Unknown` |
| OrderDate stored as text | 600 | Converted to real dates |

Checks that passed: no duplicate OrderIDs, and Revenue, Cost and Profit calculate correctly in every row.
Helper columns added: Year, MonthNum, MonthName.

## Validation

The same totals were reproduced in all three tools:

- Rows: **600**
- Revenue: **£136,722.05**
- Profit: **£56,016.85**
- Overall margin: **40.97%**

## Key findings and recommendations

| # | Finding | Evidence | Suggested action |
|---|---|---|---|
| 1 | Furniture earns the most profit but has the lowest margin | £24.6K profit at 36.4% margin, against 41.0% overall | Review pricing and supplier costs, starting with Standing Desk |
| 2 | Standing Desk and Monitor sell well but have weak margins | Standing Desk 29.2%, Monitor 34.7%; about £18K profit between them | Test a small price rise or negotiate unit costs |
| 3 | Discounts reduce margin at every level | 44.18% at 0% discount, down to 29.90% at 15% | Limit 15% discounts, especially on low-margin products |
| 4 | The weakest orders are discounted ones | All 11 orders below 30% margin carried a discount (9 Standing Desk, 2 Monitor) | Stop discounting these products or set a minimum margin rule |
| 5 | South East has the weakest regional margin, Scotland the strongest | South East 38.52% on £35K revenue; Scotland 47.41% on £8K | Investigate South East's product and discount mix; explore growing Scotland |

Other observations: sales peak in April and are lowest in December, and small items such as Reusable Cup have margins above 60% but contribute little profit.

**Note:** these are patterns in the data worth investigating. The analysis does not prove that discounts caused the weak margins or whether discounted customers would have bought at full price.

## Files

| File | Description |
|---|---|
| `Retail_Sales_Project_Cleaned.xlsx` | Cleaned data, PivotTables and `CleaningLog` sheet |
| `sales_queries.sql` | Seven commented SQL queries |
| `Retail_Sales_Dashboard.pbix` | Power BI dashboard |
| `images/` | Dashboard screenshots |

## What I learned

- Cleaning data before analysis, including problems that Excel filters hide (case differences and extra spaces)
- Checking results across tools to make sure the numbers agree
- Writing SQL with `GROUP BY`, `FETCH FIRST` and window functions (`RANK() OVER`)
- Building measures in Power BI (profit margin as a ratio of totals)
- Turning numbers into recommendations
