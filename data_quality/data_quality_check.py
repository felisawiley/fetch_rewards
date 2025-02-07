"""
data_quality_check.py

This script evaluates data quality issues in the Fetch Rewards dataset. 
It scans for:
- Missing values
- Duplicate records
- Invalid data types
- Out-of-range values
- Inconsistent categorical values

Usage:
Run this script in the root project directory.
"""

import gzip
import json
import os
import pandas as pd

# Directory containing the data files
DATA_DIR = "/Users/felisa/Desktop/Business Ideas/fetch-analytics/data"

# Define expected column types
EXPECTED_TYPES = {
    "users": {
        "user_id": str,
        "active": bool,
        "createdDate": str,  # Will check for valid timestamps later
        "lastLogin": str,  # Will check for valid timestamps
        "role": str,
        "signUpSource": str,
        "state": str
    },
    "receipts": {
        "receipt_id": str,
        "bonusPointsEarned": int,
        "bonusPointsEarnedReason": str,
        "createDate": str,
        "dateScanned": str,
        "finishedDate": str,
        "modifyDate": str,
        "pointsAwardedDate": str,
        "pointsEarned": float,
        "purchaseDate": str,
        "purchasedItemCount": int,
        "rewardsReceiptStatus": str,
        "totalSpent": float,
        "userId": str
    },
    "brands": {
        "barcode": str,
        "brandCode": str,
        "category": str,
        "categoryCode": str,
        "cpg": str,
        "name": str,
        "topBrand": bool
    }
}


def read_gz_json(file_path):
    """Reads a gzipped JSON file and returns a list of records."""
    records = []
    with gzip.open(file_path, 'rt', encoding='utf-8') as f:
        for line in f:
            try:
                records.append(json.loads(line))
            except json.JSONDecodeError:
                print(f"Skipping invalid JSON line in {file_path}")
    return records

def check_missing_values(df):
    """Identifies missing values in the dataset."""
    missing = df.isnull().sum()
    return missing[missing > 0]

def check_duplicates(df, unique_col):
    """Checks for duplicate entries in the dataset based on a unique identifier."""
    if unique_col not in df.columns:
        print(f"Warning: Column '{unique_col}' not found in DataFrame. Skipping duplicate check.")
        return 0  # Return 0 duplicates since we can't check

    return df[df.duplicated(subset=[unique_col], keep=False)].shape[0]

def check_invalid_data_types(df, expected_types):
    """Compares column data types against expected types."""
    invalid_types = {}
    for col, expected_type in expected_types.items():
        if col in df.columns:
            actual_type = df[col].dropna().apply(type).unique()
            if not all(issubclass(t, expected_type) for t in actual_type):
                invalid_types[col] = actual_type
    return invalid_types

def check_out_of_range_values(df, column, min_val=None, max_val=None):
    """Checks if numeric values fall outside an expected range."""
    if column in df.columns and df[column].dtype in ["int64", "float64"]:
        return df[(df[column] < min_val) | (df[column] > max_val)].shape[0]
    return 0

def validate_categorical_values(df, column, valid_values):
    """Identifies invalid categorical values in a given column."""
    if column in df.columns:
        return df[~df[column].isin(valid_values)][column].unique()
    return []

def evaluate_data_quality():
    """Runs data quality checks on all dataset files."""
    for filename in os.listdir(DATA_DIR):
        if filename.endswith(".json.gz"):
            table_name = filename.replace(".json.gz", "")
            file_path = os.path.join(DATA_DIR, filename)

            print(f"\n--- Checking {table_name} ---")
            records = read_gz_json(file_path)
            if not records:
                print(f"Warning: No valid records found in {filename}")
                continue

            df = pd.DataFrame(records)

            # Debugging: Print available columns
            print(f"Columns found in {table_name}: {list(df.columns)}")

            # Rename `_id` to `receipt_id` if needed
            if "_id" in df.columns and table_name == "receipts":
                df.rename(columns={"_id": "receipt_id"}, inplace=True)

            # Check missing values
            missing = check_missing_values(df)
            if not missing.empty:
                print("Missing Values Detected:")
                print(missing)

            # Check duplicates
            unique_col = list(EXPECTED_TYPES[table_name].keys())[0]  # Assuming first column as unique identifier
            duplicates = check_duplicates(df, unique_col)
            if duplicates > 0:
                print(f"Duplicate Records Found: {duplicates}")

            # Check invalid data types
            invalid_types = check_invalid_data_types(df, EXPECTED_TYPES[table_name])
            if invalid_types:
                print("Invalid Data Types Found:")
                print(invalid_types)

            # Check out-of-range values (Example: total_spent should be positive)
            if "totalSpent" in df.columns:
                out_of_range = check_out_of_range_values(df, "totalSpent", min_val=0)
                if out_of_range > 0:
                    print(f"Out-of-range Values in totalSpent: {out_of_range}")

if __name__ == "__main__":
    evaluate_data_quality()