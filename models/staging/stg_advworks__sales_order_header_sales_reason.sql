with source as (
    select * from {{ source('advworks', 'sales_salesorderheadersalesreason') }}
),

renamed as (
    select
        -- Composite Primary Key (Bridge Table)
        cast(salesorderid as bigint) as sales_order_fk,
        cast(salesreasonid as bigint) as sales_reason_fk,
        
        -- System columns
        cast(modifieddate as string) as last_updated_at
        
    from source
)

select * from renamed