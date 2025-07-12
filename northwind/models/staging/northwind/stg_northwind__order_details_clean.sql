WITH order_details_clean AS(
    SELECT
        order_id,
        unit_price,
        quantity,
        discount,
        product_id
    FROM
        {{ref('raw_northwind__order_details')}}
)
SELECT
    *
FROM
    order_details_clean