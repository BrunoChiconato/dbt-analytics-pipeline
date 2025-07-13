with revenues_1997 as (

    select
        sum(item_revenue) as total_revenues_1997
    from
        {{ ref('int_order_items_enriched') }}
    where
        order_year = 1997

)

select * from revenues_1997