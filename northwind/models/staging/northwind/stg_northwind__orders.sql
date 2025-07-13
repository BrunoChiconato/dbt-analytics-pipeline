with source as (

    select * from {{ source('northwind', 'orders') }}

),

renamed as (

    select
        -- Identificadores
        order_id,
        customer_id,

        -- Timestamps
        order_date

    from source

),

type_casted as (

    select
        cast(order_id as integer) as order_id,
        cast(customer_id as varchar) as customer_id,
        cast(order_date as date) as order_date

    from renamed

)

select * from type_casted