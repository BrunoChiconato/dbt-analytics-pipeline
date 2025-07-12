WITH orders_clean AS(
    SELECT
        order_id,
        order_date,
        customer_id
    FROM
        {{ref('raw_northwind__orders')}}
)
SELECT
    *
FROM
    orders_clean