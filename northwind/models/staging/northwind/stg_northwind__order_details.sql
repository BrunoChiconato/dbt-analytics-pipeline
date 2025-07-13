with source as (

    select * from {{ source('northwind', 'order_details') }}

),

renamed as (

    select
        -- Identificadores
        order_id,
        product_id,

        -- Métricas
        unit_price,
        quantity,
        discount

    from source

),

type_casted as (

    select
        cast(order_id as integer) as order_id,
        cast(product_id as integer) as product_id,
        cast(unit_price as decimal(10,2)) as unit_price,
        cast(quantity as integer) as quantity,
        cast(discount as decimal(3,2)) as discount_percentage

    from renamed

)

select * from type_casted