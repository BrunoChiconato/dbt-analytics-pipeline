with product_sales as (

    select
        product_id,
        product_name,
        sum(item_revenue) as total_sales
    from
        {{ ref('int_order_items_enriched') }}
    group by
        1,
        2

),

top_products as (

    select
        product_id,
        product_name,
        total_sales,
        row_number() over (order by total_sales desc) as sales_rank
    from
        product_sales

)

select
    product_id,
    product_name,
    total_sales,
    sales_rank
from
    top_products
where
    sales_rank <= 10
order by
    sales_rank