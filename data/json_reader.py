"""
json_reader.py

This script loops through all `.json.gz` files in the `data` folder and prints
one record from each. If a file contains multiple JSON objects, only the first
valid one is shown. 

Usage:
- Run this script inside the root directory of your project.
- Make sure the `data` folder exists and contains `.json.gz` files.
"""

import gzip
import json
import os
from pprint import pprint

def read_gz_json(filename):
    """Reads a gzipped JSON file and returns the first valid record."""
    with gzip.open(filename, 'rt', encoding='utf-8') as f:
        for line in f:
            try:
                return json.loads(line)  # Grab the first valid JSON record
            except json.JSONDecodeError:
                print(f"Couldn't parse a line in {filename}: {line[:100]}...")
                continue
    return None  # If we can't get a valid record, return None

def process_all_files(directory):
    """Loops through all .json.gz files in the given directory and prints one record from each."""
    if not os.path.exists(directory):
        print(f"Error: The directory '{directory}' doesn't exist. Check your path.")
        return
    
    files_found = [f for f in os.listdir(directory) if f.endswith(".json.gz")]

    if not files_found:
        print("No .json.gz files found in the directory.")
        return

    for filename in files_found:
        filepath = os.path.join(directory, filename)
        print(f"\n--- Reading from {filename} ---")
        data = read_gz_json(filepath)
        if data:
            pprint(data)
        else:
            print(f"No valid records found in {filename}.")

# Get the absolute path of this script and use it to locate the data folder
script_dir = os.path.dirname(os.path.abspath(__file__))
data_directory = os.path.join(script_dir) 

process_all_files(data_directory)
