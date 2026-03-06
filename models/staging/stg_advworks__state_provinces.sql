with source as (
    select * from {{ source('advworks', 'person_stateprovince') }}
),

renamed as (
    select
        -- Primary Key
        cast(stateprovinceid as bigint) as state_province_pk,
        
        -- Foreign Key
        cast(territoryid as bigint) as territory_fk,
        
        -- State/Province Info
        cast(stateprovincecode as string) as state_province_code,
        cast(countryregioncode as string) as country_region_code,
        cast(name as string) as state_province_name,
        cast(isonlystateprovinceflag as boolean) as is_only_state_province,
        
        -- System columns
        cast(rowguid as string) as rowguid,
        cast(modifieddate as string) as last_updated_at
        
    from source
)

select * from renamed