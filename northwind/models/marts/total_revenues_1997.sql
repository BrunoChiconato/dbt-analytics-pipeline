SELECT
    SUM((order_details.unit_price) * order_details.quantity * (1.0 - order_details.discount)) AS total_revenues_1997
FROM
    {{ref('stg_northwind__order_details_clean')}} order_details
INNER JOIN (
    SELECT
        order_id
    FROM
        {{ref('stg_northwind__orders_clean')}} orders
    WHERE
        EXTRACT(YEAR FROM order_date) = '1997'
) AS ord
ON
    ord.order_id = order_details.order_id