{{ config(
    materialized='ephemeral'
) }}

with orders as (

    select * from {{ ref('stg_northwind__orders') }}

),

order_details as (

    select * from {{ ref('stg_northwind__order_details') }}

),

products as (

    select * from {{ ref('stg_northwind__products') }}

),

order_items_joined as (

    select
        -- Identificadores
        orders.order_id,
        orders.customer_id,
        order_details.product_id,

        -- Dimensões temporais
        orders.order_date,
        extract(year from orders.order_date) as order_year,
        extract(month from orders.order_date) as order_month,

        -- Informações do produto
        products.product_name,

        -- Métricas do item
        order_details.unit_price,
        order_details.quantity,
        order_details.discount_percentage,

        -- Cálculo de receita
        order_details.unit_price * order_details.quantity * (1.0 - order_details.discount_percentage) as item_revenue

    from
        orders
    inner join
        order_details
    on
        orders.order_id = order_details.order_id
    inner join
        products
    on
        order_details.product_id = products.product_id

)

select * from order_items_joined