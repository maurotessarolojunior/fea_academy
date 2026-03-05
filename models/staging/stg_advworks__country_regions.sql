with source as (
    select * from {{ source('advworks', 'person_countryregion') }}
),

renamed as (
    select
        -- Primary Key
        cast(countryregioncode as string) as country_region_pk,
        
        -- Country Info
        cast(name as string) as country_name,
        
        -- System columns
        cast(modifieddate as string) as last_updated_at
        
    from source
)

select * from renamed