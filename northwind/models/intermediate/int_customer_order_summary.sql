{{ config(
    materialized='ephemeral'
) }}

with customers as (

    select * from {{ ref('stg_northwind__customers') }}

),

order_items as (

    select * from {{ ref('int_order_items_enriched') }}

),

customer_metrics as (

    select
        customer_id,
        count(distinct order_id) as total_orders,
        sum(item_revenue) as total_revenue,
        min(order_date) as first_order_date,
        max(order_date) as last_order_date
    from
        order_items
    group by
        1

),

customer_summary as (

    select
        customers.customer_id,
        customers.company_name,
        customers.contact_name,
        customers.country,
        coalesce(customer_metrics.total_orders, 0) as total_orders,
        coalesce(customer_metrics.total_revenue, 0) as total_revenue,
        customer_metrics.first_order_date,
        customer_metrics.last_order_date
    from
        customers
    left join
        customer_metrics
    on
        customers.customer_id = customer_metrics.customer_id

)

select * from customer_summary