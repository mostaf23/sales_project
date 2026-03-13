# 🛒 Retail Sales Data Analysis (SQL + Power BI)

## 📌 Project Overview

This project focuses on analyzing retail sales data using **SQL Server** and visualizing insights using **Power BI Dashboard**.

The project includes:

* Data importing
* Data cleaning
* Data transformation
* Business insights generation
* Interactive dashboard visualization

The goal is to help businesses understand **sales performance, customer behavior, and product trends** to support data-driven decision making.

---

# 🗂 Dataset Description

The dataset contains retail transaction data including:

| Column           | Description                                     |
| ---------------- | ----------------------------------------------- |
| transaction_id   | Unique ID for each transaction                  |
| customer_id      | Unique customer identifier                      |
| customer_name    | Customer name                                   |
| customer_age     | Age of the customer                             |
| gender           | Customer gender                                 |
| product_id       | Product identifier                              |
| product_name     | Product name                                    |
| product_category | Product category                                |
| quantity         | Number of items purchased                       |
| price            | Price per item                                  |
| payment_mode     | Payment method                                  |
| purchase_date    | Date of purchase                                |
| time_of_purchase | Purchase time                                   |
| status           | Order status (Delivered / Cancelled / Returned) |

---

# 🧹 Data Cleaning Process (SQL)

Several steps were applied to ensure high-quality data.

### 1️⃣ Removing Duplicate Transactions

Duplicate `transaction_id` values were detected using:

* `GROUP BY`
* `HAVING COUNT(*)`

Duplicates were removed using:

```sql
ROW_NUMBER() OVER(PARTITION BY transaction_id)
```

---

### 2️⃣ Fixing Column Names

Incorrect column names were corrected using:

* `sp_rename`

Examples:

* `quantiy` → `quantity`
* `prce` → `price`

---

### 3️⃣ Checking Data Types

Column data types were verified using:

```sql
INFORMATION_SCHEMA.COLUMNS
```

---

### 4️⃣ Handling Missing Values

A dynamic SQL query was used to detect **NULL values in all columns**.

Rows with critical missing values such as `transaction_id` were removed.

---

### 5️⃣ Standardizing Data

Data values were standardized to improve consistency:

**Gender**

* Male → M
* Female → F

**Payment Mode**

* CC → Credit Card

---

# 📊 Business Insights (SQL Analysis)

The following business questions were answered using SQL queries.

---

## 🔥 Top 5 Most Selling Products

Identifies products with the highest quantity sold.

**Business Impact**

* Improve inventory planning
* Focus marketing efforts on best-selling items

---

## ❌ Most Frequently Cancelled Products

Identifies products with the highest cancellation rates.

**Business Impact**

* Detect quality issues
* Improve product descriptions

---

## 🕒 Peak Purchase Time

Analyzes purchase activity during different times of the day:

* Night
* Morning
* Afternoon
* Evening

**Business Impact**

* Optimize staffing
* Schedule promotions effectively

---

## 👑 Top 5 Highest Spending Customers

Identifies VIP customers based on total spending.

**Business Impact**

* Customer loyalty programs
* Personalized marketing offers

---

## 💰 Highest Revenue Product Categories

Shows which categories generate the most revenue.

**Business Impact**

* Focus on profitable product categories
* Improve product strategy

---

## 📉 Cancellation Rate by Category

Calculates cancellation percentage for each product category.

**Business Impact**

* Identify problematic product categories
* Reduce cancellation rates

---

## 🔁 Return Rate by Category

Shows return percentage by category.

**Business Impact**

* Improve product quality
* Reduce returns

---

## 💳 Most Preferred Payment Method

Identifies the most used payment methods by customers.

**Business Impact**

* Improve payment systems
* Focus on preferred payment options

---

## 📈 Monthly Sales Trend

Analyzes monthly revenue and quantity sold.

**Business Impact**

* Identify seasonal sales trends
* Improve demand forecasting

---

# 📊 Power BI Dashboard

An **interactive dashboard** was created using **Power BI** to visualize the insights generated from SQL analysis.

### Dashboard Features

* Total Sales Overview
* Top Selling Products
* Revenue by Product Category
* Sales by Time of Day
* Customer Spending Analysis
* Payment Method Distribution
* Monthly Sales Trend
* Cancellation and Return Analysis

The dashboard enables stakeholders to quickly explore the data and make better business decisions.

---

# 🛠 Tools Used

* **SQL Server**
* **T-SQL**
* **Power BI**
* **Data Cleaning Techniques**
* **Window Functions**
* **Data Aggregation**

---

# 📌 Skills Demonstrated

* SQL Data Cleaning
* Data Transformation
* Duplicate Removal
* Handling Missing Data
* Business Data Analysis
* Data Visualization
* Dashboard Development
* Business Insight Generation


