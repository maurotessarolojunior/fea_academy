with source as (
    select * from {{ source('advworks', 'production_productmodel') }}
),

renamed as (
    select
        -- Primary Key
        cast(productmodelid as bigint) as product_model_pk,
        
        -- Model Info
        cast(name as string) as model_name,
        cast(catalogdescription as string) as catalog_description,
        cast(instructions as string) as instructions,
        
        -- System columns
        cast(rowguid as string) as rowguid,
        cast(modifieddate as string) as last_updated_at
        
    from source
)

select * from renamed