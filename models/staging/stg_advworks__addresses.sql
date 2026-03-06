with source as (
    select * from {{ source('advworks', 'person_address') }}
),

renamed as (
    select
        -- Primary Key
        cast(addressid as bigint) as address_pk,
        
        -- Foreign Key
        cast(stateprovinceid as bigint) as state_province_fk,
        
        -- Address Info
        cast(addressline1 as string) as address_line_1,
        cast(addressline2 as string) as address_line_2,
        cast(city as string) as city,
        cast(postalcode as string) as postal_code,
        cast(spatiallocation as string) as spatial_location,
        
        -- System columns
        cast(rowguid as string) as rowguid,
        cast(modifieddate as string) as last_updated_at
        
    from source
)

select * from renamed