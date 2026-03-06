with source as (
    select * from {{ source('advworks', 'sales_salesperson') }}
),

renamed as (
    select
        -- Primary Key
        cast(businessentityid as bigint) as salesperson_pk,
        
        -- Foreign Key
        cast(territoryid as double) as territory_fk,
        
        -- Salesperson Info
        cast(salesquota as double) as sales_quota,
        cast(bonus as double) as bonus,
        cast(commissionpct as double) as commission_pct,
        cast(salesytd as double) as sales_ytd,
        cast(saleslastyear as double) as sales_last_year,
        
        -- System columns
        cast(rowguid as string) as rowguid,
        cast(modifieddate as string) as last_updated_at
        
    from source
)

select * from renamed