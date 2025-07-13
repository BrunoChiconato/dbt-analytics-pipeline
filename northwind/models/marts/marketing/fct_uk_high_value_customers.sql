with uk_customers as (

    select
        customer_id,
        contact_name,
        total_revenue
    from
        {{ ref('int_customer_order_summary') }}
    where
        lower(country) = 'uk'
        and total_revenue > 1000

)

select
    customer_id,
    contact_name,
    round(total_revenue, 2) as payments
from
    uk_customers
order by
    payments desc