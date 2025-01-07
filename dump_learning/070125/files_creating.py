import numpy as np
import pandas as pd

# Generate sales_extended.csv
np.random.seed(42)
sales_extended_data = {
    "SaleID": range(1, 201),
    "Region": np.random.choice(['North', 'South', 'West', 'East'], 200),
    "Amount": np.random.randint(50, 2000, 200),
    "Date": pd.date_range(start="2024-01-01", periods=200, freq="D").strftime("%Y-%m-%d"),
    "ProductCategory": np.random.choice(['Electronics', 'Furniture', 'Clothing', 'Food'], 200)
}
sales_extended_df = pd.DataFrame(sales_extended_data)
sales_extended_df.to_csv('sales_extended.csv', index=False)

# Generate customers_extended.csv
customers_extended_data = {
    "CustomerID": range(1, 101),
    "Name": [f"Customer_{i}" for i in range(1, 101)],
    "Region": np.random.choice(['North', 'South', 'West', 'East'], 100),
    "TotalPurchases": np.random.randint(1, 50, 100),
    "TotalSpent": np.random.randint(500, 10000, 100)
}
customers_extended_df = pd.DataFrame(customers_extended_data)
customers_extended_df.to_csv('customers_extended.csv', index=False)

