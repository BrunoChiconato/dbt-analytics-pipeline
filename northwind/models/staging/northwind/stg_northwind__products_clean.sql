WITH products_clean AS (
    SELECT
        product_id,
        product_name
    FROM
        {{ref('raw_northwind__products')}}
)
SELECT
    *
FROM
    products_clean