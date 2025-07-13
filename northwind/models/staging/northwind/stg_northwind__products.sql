with source as (

    select * from {{ source('northwind', 'products') }}

),

renamed as (

    select
        -- Identificadores
        product_id,

        -- Descrições
        product_name

    from source

),

type_casted as (

    select
        cast(product_id as integer) as product_id,
        cast(product_name as varchar) as product_name

    from renamed

)

select * from type_casted