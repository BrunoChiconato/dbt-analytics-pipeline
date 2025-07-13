with customer_groups as (

    select * from {{ ref('dim_customer_groups') }}

),

marketing_targets as (

    select
        customer_id,
        company_name,
        total_revenue,
        revenue_group
    from
        customer_groups
    where
        revenue_group >= 3

)

select
    *
from
    marketing_targets
order by
    total_revenue desc