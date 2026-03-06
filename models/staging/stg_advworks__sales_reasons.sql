with source as (
    select * from {{ source('advworks', 'sales_salesreason') }}
),

renamed as (
    select
        -- Primary Key
        cast(salesreasonid as bigint) as sales_reason_pk,
        
        -- Sales Reason Info
        cast(name as string) as sales_reason_name,
        cast(reasontype as string) as reason_type,
        
        -- System columns
        cast(modifieddate as string) as last_updated_at
        
    from source
)

select * from renamed