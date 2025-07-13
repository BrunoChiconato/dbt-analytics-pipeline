with source as (

    select * from {{ source('northwind', 'customers') }}

),

renamed as (

    select
        -- Identificadores
        customer_id,

        -- Informações da empresa
        company_name,
        contact_name,

        -- Localização
        country

    from source

),

type_casted as (

    select
        cast(customer_id as varchar) as customer_id,
        cast(company_name as varchar) as company_name,
        cast(contact_name as varchar) as contact_name,
        cast(country as varchar) as country

    from renamed

)

select * from type_casted