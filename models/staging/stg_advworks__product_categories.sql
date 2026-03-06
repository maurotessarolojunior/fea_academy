with source as (
    select * from {{ source('advworks', 'production_productcategory') }}
),

renamed as (
    select
        -- Primary Key
        cast(productcategoryid as bigint) as product_category_pk,
        
        -- Category Info
        cast(name as string) as category_name,
        
        -- System columns
        cast(rowguid as string) as rowguid,
        cast(modifieddate as string) as last_updated_at
        
    from source
)

select * from renamed