--- Checking receipts ---

Columns found in receipts: ['_id', 'bonusPointsEarned', 'bonusPointsEarnedReason', 'createDate', 'dateScanned', 'finishedDate', 'modifyDate', 'pointsAwardedDate', 'pointsEarned', 'purchaseDate', 'purchasedItemCount', 'rewardsReceiptItemList', 'rewardsReceiptStatus', 'totalSpent', 'userId']

Missing Values Detected:
bonusPointsEarned          575
bonusPointsEarnedReason    575
finishedDate               551
pointsAwardedDate          582
pointsEarned               510
purchaseDate               448
purchasedItemCount         484
rewardsReceiptItemList     440
totalSpent                 435

dtype: int64

Invalid Data Types Found:
{'receipt_id': array([<class 'dict'>], dtype=object), 'bonusPointsEarned': array([<class 'float'>], dtype=object), 'createDate': array([<class 'dict'>], dtype=object), 'dateScanned': array([<class 'dict'>], dtype=object), 'finishedDate': array([<class 'dict'>], dtype=object), 'modifyDate': array([<class 'dict'>], dtype=object), 'pointsAwardedDate': array([<class 'dict'>], dtype=object), 'pointsEarned': array([<class 'str'>], dtype=object), 'purchaseDate': array([<class 'dict'>], dtype=object), 'purchasedItemCount': array([<class 'float'>], dtype=object), 'totalSpent': array([<class 'str'>], dtype=object)}

--- Checking users ---

Skipping invalid JSON line in /Users/felisa/Desktop/Business Ideas/fetch-analytics/data/users.json.gz

Skipping invalid JSON line in /Users/felisa/Desktop/Business Ideas/fetch-analytics/data/users.json.gz

Columns found in users: ['_id', 'active', 'createdDate', 'lastLogin', 'role', 'signUpSource', 'state']
Missing Values Detected:
lastLogin       62
signUpSource    48
state           56

dtype: int64

Warning: Column 'user_id' not found in DataFrame. Skipping duplicate check.

Invalid Data Types Found:
{'createdDate': array([<class 'dict'>], dtype=object), 'lastLogin': array([<class 'dict'>], dtype=object)}

--- Checking brands ---

Columns found in brands: ['_id', 'barcode', 'category', 'categoryCode', 'cpg', 'name', 'topBrand', 'brandCode']

Missing Values Detected:
category        155
categoryCode    650
topBrand        612
brandCode       234

dtype: int64

Duplicate Records Found: 14

Invalid Data Types Found:
{'cpg': array([<class 'dict'>], dtype=object)}
