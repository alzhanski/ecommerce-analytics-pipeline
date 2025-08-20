{% docs customers%}

## Data Quality Analysis
- **Customer Addresses**: Analysis revealed customers have multiple zip codes (1-17 per customer)
- **Business Logic**: Customers legitimately have multiple shipping/billing addresses
- **Validation Query**: `SELECT customer_unique_id, count(customer_zipcode) FROM customers GROUP BY 1`
- **Decision**: Removed unique constraint on customer_unique_id as it's not applicable to this business model

{% enddocs %}