with source as (
    select * from {{ source('advworks', 'production_productsubcategory') }}
),

renamed as (
    select
        -- Primary Key
        cast(productsubcategoryid as bigint) as product_subcategory_pk,
        
        -- Foreign Key
        cast(productcategoryid as bigint) as product_category_fk,
        
        -- Subcategory Info
        cast(name as string) as subcategory_name,
        
        -- System columns
        cast(rowguid as string) as rowguid,
        cast(modifieddate as string) as last_updated_at
        
    from source
)

select * from renamed