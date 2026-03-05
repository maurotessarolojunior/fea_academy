with source as (
    select * from {{ source('advworks', 'sales_customer') }}
),

renamed as (
    select
        -- Primary Key
        cast(CustomerID as bigint) as customer_pk,
        
        -- Foreign Keys
        cast(PersonID as double) as person_fk,
        cast(StoreID as double) as store_fk,
        cast(TerritoryID as bigint) as territory_fk,
        
        -- System columns
        cast(rowguid as string) as rowguid,
        cast(ModifiedDate as date) as last_updated_at
        
    from source
)

select * from renamed