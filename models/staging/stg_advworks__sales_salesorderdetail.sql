with source as (
    select * from {{ source('advworks', 'sales_salesorderdetail') }}
),

renamed as (
    select
        -- Primary Key
        cast(SalesOrderDetailID as bigint) as sales_order_detail_pk,
        
        -- Foreign Keys
        cast(SalesOrderID as bigint) as sales_order_fk,
        cast(ProductID as bigint) as product_fk,
        cast(SpecialOfferID as bigint) as special_offer_fk,
        
        -- Order Details
        cast(OrderQty as bigint) as order_quantity,
        cast(UnitPrice as double) as unit_price,
        cast(UnitPriceDiscount as double) as unit_price_discount,
        
        -- Calculated field
        cast(UnitPrice as double) * cast(OrderQty as bigint) * (1 - cast(UnitPriceDiscount as double)) as line_total,
        
        -- System columns
        cast(rowguid as string) as rowguid,
        cast(ModifiedDate as date) as last_updated_at
        
    from source
)

select * from renamed