# Fetch Rewards Data Quality Analysis
## Overview
A data quality evaluation of the Fetch Rewards dataset identified several key issues that could impact data integrity, analytics, and reporting. These issues fall into four primary categories: missing values, incorrect data types, duplicate records, and inconsistencies in categorical values. The following is a structured breakdown of findings across the receipts, users, and brands datasets.

## 1. Receipts Data Issues
### Missing Values
- Bonus Points Earned (575 records missing): A significant number of records are missing this value, which affects the accuracy of rewards calculations.
- Bonus Points Earned Reason (575 records missing): The absence of this data limits visibility into how and why points were awarded.
- Finished Date (551 records missing): Without this field, it is difficult to track the lifecycle of receipts and determine when processing was completed.
- Points Awarded Date (582 records missing): This impacts tracking when users were credited with points, creating gaps in reward validation.
- Points Earned (510 records missing): Missing data in this field prevents accurate reporting on user incentives and earned rewards.
Purchase Date (448 records missing): The absence of this value makes it difficult to analyze purchasing behavior over time.
- Purchased Item Count (484 records missing): Without this, it is unclear how many items were included in each transaction.
- Rewards Receipt Item List (440 records missing): This affects product-level insights and limits the ability to analyze shopping patterns.
- Total Spent (435 records missing): Without total purchase amounts, consumer spending analytics and financial reporting are incomplete.
### Invalid Data Types
- receipt_id is stored as a dictionary instead of a string, which deviates from standard data structuring.
Date fields (createDate, dateScanned, finishedDate, modifyDate, pointsAwardedDate, purchaseDate) are stored as dictionaries rather than proper timestamp formats.
- Points Earned and Total Spent are stored as strings instead of numeric values.
- Purchased Item Count and Bonus Points Earned are stored as floating-point values when they should be integers.


## 2. Users Data Issues
### Missing Values
- Last Login (62 records missing): Without this data, it is difficult to determine user engagement and retention.
- Sign-Up Source (48 records missing): Missing values prevent full visibility into user acquisition channels (Email, Google, Facebook, Apple, etc.).
- State (56 records missing): The absence of state data limits geographic analysis.
### Invalid Data Types
- Created Date and Last Login are stored as dictionaries instead of timestamps, leading to inconsistencies in tracking user activity.
### Other Issues
- User ID is missing as a named field. Instead, _id is being used, which should be standardized to user_id to ensure consistency across the database.

## 3. Brands Data Issues
### Missing Values
- Category (155 records missing): Missing product categorization reduces classification accuracy.
- Category Code (650 records missing): A significant portion of records lack a category reference, impacting the ability to filter and organize brands.
- Top Brand (612 records missing): The absence of this flag makes it challenging to rank or feature brands in analytics and marketing efforts.
- Brand Code (234 records missing): Missing brand codes affect lookup and filtering functions.
### Duplicates
- 14 duplicate brand records identified. While not a large number, these should be addressed to maintain data integrity and avoid redundancy.
### Invalid Data Types
- CPG (Consumer Packaged Goods) field is stored as a dictionary rather than an ID or string reference, which affects relational database design and efficient querying.

## Conclusion
The dataset contains several structural issues that impact data reliability and usability. Missing values, particularly in key fields such as purchase amounts, receipt details, and timestamps, reduce the accuracy of analytics and reporting. Inconsistent data types introduce processing challenges, while duplicate records and misclassified categorical values could lead to erroneous insights. Standardizing these elements will be critical to improving data integrity and ensuring consistency across Fetch Rewards' system.
