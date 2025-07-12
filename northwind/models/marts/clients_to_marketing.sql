WITH clients_to_marketing AS (
    SELECT
        customers.company_name,
        SUM(order_details.unit_price * order_details.quantity * (1.0 - order_details.discount)) AS total,
        NTILE(5) OVER (ORDER BY SUM(order_details.unit_price * order_details.quantity * (1.0 - order_details.discount)) DESC) AS group_number
    FROM
        {{ref('stg_northwind__customers_clean')}} customers
    INNER JOIN
        {{ref('stg_northwind__orders_clean')}} orders
    ON
        customers.customer_id = orders.customer_id
    INNER JOIN
        {{ref('stg_northwind__order_details_clean')}} order_details
    ON
        order_details.order_id = orders.order_id
    GROUP BY
        customers.company_name
    ORDER BY
        total DESC
)
SELECT
    *
FROM
    clients_to_marketing
WHERE
    group_number >= 3