-- test AGAIN
with customer_revenues as (

    select
        customer_id,
        company_name,
        total_revenue,
        ntile(5) over (order by total_revenue desc) as revenue_group
    from
        {{ ref('int_customer_order_summary') }}
    where
        total_revenue > 0

)

select
    *
from
    customer_revenues
order by
    total_revenue desc