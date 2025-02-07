# Fetch Rewards Database Schema & Entity-Relationship Summary
**Author:** Felisa Wiley

## Overview
This document provides a high-level summary of the Fetch Rewards relational database schema and entity-relationship (ER) model. It includes details on table relationships, key constraints, and standardized column names to ensure consistency and data integrity. This document supports efficient query development, reporting, and business analysis.

## Entity-Relationship Diagram (ERD)
The **ERD** illustrates how data flows between key entities in the Fetch Rewards system. It includes:
- **Users**: Represents registered users who scan receipts.
- **Receipts**: Contains transaction details of scanned receipts.
- **Receipt Items**: Stores individual items purchased in each receipt.
- **Brands**: Represents product brands associated with scanned items.

### **Relationships**
- **One User → Many Receipts**: Each user can submit multiple receipts.
- **One Receipt → Many Receipt Items**: A single receipt can contain multiple items.
- **One Receipt Item → One Brand**: Each purchased item is associated with a brand.

## Schema Standardization
The database schema follows a **normalized relational model**, ensuring:
- **Data Consistency**: Standardized column names and constraints.
- **Performance Optimization**: Indexing primary and foreign keys for efficient queries.
- **Scalability**: Structured relationships for future business expansions.

## [Column Standardization](https://docs.google.com/spreadsheets/d/136lzARNX2Buv6A4fli3Ght-HcqvSaq65yNA3BSWoYGE/edit?usp=sharing)

To maintain clarity, **column names** have been standardized to:
- Use **snake_case** for uniformity (e.g., `created_date` instead of `createDate`).
- Prefix **Boolean fields** with `is_` for readability (e.g., `is_active`).
- Remove redundant words for conciseness (e.g., `receipt_status` instead of `rewardsReceiptStatus`).

Note: The ERD diagram contains the raw column names, while all standardized column names and modifications are documented in the Google Sheets.

## How to Use This [Google Sheet](https://docs.google.com/spreadsheets/d/136lzARNX2Buv6A4fli3Ght-HcqvSaq65yNA3BSWoYGE/edit?usp=sharing)
### **Tab 1: Database Schema (Entity-Relationship Model)**
- Visual representation of table relationships.
- Primary and foreign keys for referential integrity.
- Constraints such as `NOT NULL`, `CHECK`, and `DEFAULT` values.

### **Tab 2: Data Dictionary**
- Breakdown of each table and column, including data types and descriptions.
- Useful for writing SQL queries and debugging.

### **Tab 3: Standardized Column Names**
- List of original vs. standardized column names.
- Explanations for modifications to maintain consistency.


## Next Steps
- Utilize this document when writing SQL queries, designing reports, or performing database maintenance.
- Refer to the ERD for understanding table relationships.
- Use the data dictionary for column-level details and constraints.