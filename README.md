Fetch Rewards Analytics Engineering Exercise
This repository contains my solution for the Fetch Rewards Analytics Engineer coding exercise. The project demonstrates data modeling, SQL query writing, data quality analysis, and business communication skills.

Project Structure
fetch-rewards/
├── data/                      # Data directory (excluded from git)
│   ├── receipts.json.gz
│   ├── json_reader.py        # runs through all the json.gz files in the directory and returns one line from each
│   ├── users.json.gz
│   └── brands.json.gz
├── models/
│   ├── schema.sql            # SQL schema definitions
│   ├── er_diagram/           # Entity Relationship diagrams
│   └── README.md  # Models documentation

├── queries/
│   ├── brand_analysis.sql    # Brand-related queries
│   └── receipt_analysis.sql  # Receipt-related queries
├── data_quality/
│   ├── data_quality_checks.py    # PY data quality checks
│   ├── quality_report.md     # Documented findings
│   └── raw_findings.md     # Raw findings printed via terminal
├── communication/
│   └── email.md # Business stakeholder email
└── README.md                 # Project documentation
Requirements
SQL Database (PostgreSQL)
Python 3.8+ (if using Python for data quality analysis)
Additional dependencies listed in requirements.txt
Setup Instructions
Clone this repository
Download the data files and place them in the data/ directory
Set up your database and run the schema creation scripts
Execute the analysis queries
Project Components
1. Data Modeling
Entity Relationship diagram showing the structured relational data model
SQL schema definitions for all tables
Documentation of design decisions
2. Business Analysis Queries
SQL queries answering key business questions:

Top 5 brands by receipts scanned
Comparison of receipt statuses
3. Data Quality Analysis
Documented data quality issues
Methodology for discovering issues
Recommendations for resolution
Code used for quality checks
4. Stakeholder Communication
Clear explanation of findings
Documentation of assumptions
Recommendations for improvements
Discussion of scaling considerations
SQL Dialect
This project uses PostgreSQL for all queries and analysis.

Running the Analysis
First, set up the database schema:
psql -d database_name -f models/schema.sql
Load the data using your preferred method

Run the analysis queries:

psql -d database_name -f queries/brand_analysis.sql
Data Quality Findings
Key findings from the data quality analysis can be found in data_quality/quality_report.md

Future Improvements
Additional data validation steps
Performance optimization opportunities
Suggested schema improvements
Automated quality checks
