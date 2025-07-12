WITH monthly_income AS (
    SELECT
        EXTRACT(YEAR FROM orders.order_date) AS order_year,
        EXTRACT(MONTH FROM orders.order_date) AS order_month,
        SUM(order_details.unit_price * order_details.quantity * (1.0 - order_details.discount)) AS total
    FROM
        {{ref('stg_northwind__orders_clean')}} orders
    INNER JOIN
        {{ref('stg_northwind__order_details_clean')}} order_details
    ON
        orders.order_id = order_details.order_id
    GROUP BY
        EXTRACT(YEAR FROM orders.order_date),
        EXTRACT(MONTH FROM orders.order_date)
),
accumulated_revenues AS (
    SELECT
        order_year,
        order_month,
        total,
        SUM(total) OVER (PARTITION BY order_year ORDER BY order_month) AS ytd_revenue
    FROM
        monthly_income
)
SELECT
    order_year,
    order_month,
    total,
    total - LAG(total) OVER (PARTITION BY order_year ORDER BY order_month) AS monthly_diff,
    ytd_revenue,
    (total - LAG(total) OVER (PARTITION BY order_year ORDER BY order_month)) / LAG(total) OVER (PARTITION BY order_year ORDER BY order_month) * 100 AS change_percentage
FROM
    accumulated_revenues
ORDER BY
    order_year,
    order_month