WITH customers_clean AS (
    SELECT
        customer_id,
        company_name,
        contact_name,
        country
    FROM
        {{ref('raw_northwind__customers')}}
)
SELECT
    *
FROM
    customers_clean