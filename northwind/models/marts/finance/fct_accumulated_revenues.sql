with monthly_revenues as (

    select
        order_year,
        order_month,
        sum(item_revenue) as monthly_revenue
    from
        {{ ref('int_order_items_enriched') }}
    group by
        1,
        2

),

accumulated_revenues as (

    select
        order_year,
        order_month,
        monthly_revenue,
        sum(monthly_revenue) over (
            partition by order_year
            order by order_month
        ) as ytd_revenue
    from
        monthly_revenues

),

final as (

    select
        order_year,
        order_month,
        monthly_revenue,
        monthly_revenue - lag(monthly_revenue) over (
            partition by order_year
            order by order_month
        ) as monthly_diff,
        ytd_revenue,
        round(
            (monthly_revenue - lag(monthly_revenue) over (partition by order_year order by order_month))
            / nullif(lag(monthly_revenue) over (partition by order_year order by order_month), 0)
            * 100,
            2
        ) as change_percentage
    from
        accumulated_revenues

)

select
    *
from
    final
order by
    order_year,
    order_month