with customer_revenues as (

    select
        customer_id,
        company_name,
        total_revenue
    from
        {{ ref('int_customer_order_summary') }}

)

select
    *
from
    customer_revenues
order by
    total_revenue desc