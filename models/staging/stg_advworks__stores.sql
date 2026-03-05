with source as (
    select * from {{ source('advworks', 'sales_store') }}
),

renamed as (
    select
        -- Primary Key
        cast(businessentityid as bigint) as store_pk,
        
        -- Store Info
        cast(name as string) as store_name,
        cast(salespersonid as bigint) as salesperson_fk,
        cast(demographics as string) as demographics,
        
        -- System columns
        cast(rowguid as string) as rowguid,
        cast(modifieddate as string) as last_updated_at
        
    from source
)

select * from renamed