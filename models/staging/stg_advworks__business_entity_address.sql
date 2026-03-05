with source as (
    select * from {{ source('advworks', 'person_businessentityaddress') }}
),

renamed as (
    select
        -- Composite Primary Key
        cast(businessentityid as bigint) as business_entity_fk,
        cast(addressid as bigint) as address_fk,
        cast(addresstypeid as bigint) as address_type_fk,
        
        -- System columns
        cast(rowguid as string) as rowguid,
        cast(modifieddate as string) as last_updated_at
        
    from source
)

select * from renamed