# AgroNorte S.A. — Sales Analysis (SQL)

Personal project built to practice relational database design and analytical SQL.  
AgroNorte S.A. is a fictional Argentine soy and seed distributor. The database models two years of sales data (2023–2024) across customers, products, sellers and regions.

---

## What This Project Does

Builds a relational database from scratch and answers real business questions:

- Which products and categories drive the most revenue?
- Who are the top customers and how often do they buy?
- How are sellers performing across regions?
- Is the business growing month over month?

---

## Key Technical Features

- **Schema design:** 7 related tables with primary keys, foreign keys and constraints
- **Data analysis:** 15 analytical queries across 5 business areas
- **Views:** reusable query stored as a view for monthly revenue reporting
- **Stored Procedures:** parameterized procedures for seller reports and stock alerts
- **Advanced SQL:** window functions (`RANK`, `LAG`, `PARTITION BY`), subqueries, `HAVING`, date functions

---

## Project Structure

- `schema.sql` — Table definitions and relationships
- `data.sql` — Sample data for all tables
- `analysis.sql` — Queries, views and stored procedures
- `README.md` — This file

---

## How to Run

1. Open MySQL Workbench
2. Run `schema.sql`
3. Run `data.sql`
4. Run `analysis.sql`
