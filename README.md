# supply-chain-analysis
Supply chain cost optimization analysis using SQL and data analysis
# Supply Chain Cost Optimization Analysis

## Problem
Company spends $68M on supply chain without visibility into costs, quality, and delivery performance.

## Solution
Analyzed 500 purchase orders across 50 suppliers using SQL to identify optimization opportunities and cost savings.

## Key Findings
- **Top 5 suppliers = 40% of total spend** ($27.3M)
- **3 suppliers have >10% defect rate** (quality risk)
- **Only 79.2% on-time delivery** (reliability issue)
- **Potential $3-5M in annual savings** through negotiation and consolidation

## Impact
- Cost savings: $3-5M annually (4.4-7.3% of spend)
- Quality improvement: Reduce defect rate from 8.7% to <5%
- Operational efficiency: Improve on-time delivery to 90%+

## Recommendations
1. Negotiate 5-10% volume discounts with top 5 suppliers
2. Address quality issues with high-defect suppliers
3. Consolidate spend and eliminate low-value suppliers
4. Establish monthly supplier performance dashboard

## Technical Details
- **Database:** SQL Server
- **Dataset:** 500 purchase orders, 50 suppliers, 25 products
- **Queries:** 8 SQL queries with JOINs and aggregations
- **Analysis:** Cost analysis, quality assessment, risk scoring, payment status

## Files
-  `Supply_chain_analysis_2.sql` — 8 analytical SQL queries for supplier performance, costs, quality, delivery, and payment analysis.
- `Supply_Chain_Analysis_Report_FINAL.docx` — Full findings and recommendations

- ## Dataset

The `data/` folder contains the CSV tables used for this analysis:

- `Supply_Chain_products.csv` — Product information.
- `Supply_Chain_purchase_orders.csv` — Purchase-order and delivery data.
- `suppliers.csv` — Supplier information.

> Note: This project uses synthetic practice data created for portfolio analysis.

## How to Use

1. Open the `data/` folder and download the CSV files.
2. Open SQL Server Management Studio (SSMS) and create a new database, for example `SupplyChainDB`.
3. Import each CSV file into its own table.
4. Open `Supply_chain_analysis_2.sql` in SSMS.
5. Check that the table names in the SQL queries match the tables you created.
6. Run the 8 queries to analyze supplier performance, costs, quality, delivery, and payment data.
7. View the findings and recommendations in `Supply_Chain_Analysis_Report_FINAL.docx`.






**Author:** Olaide Omoyele | **Date:** 2024
