with source as (
    select * from {{ source('advworks', 'sales_salesorderdetail') }}
),

renamed as (
    select
        {{ dbt_utils.generate_surrogate_key(['SalesOrderID', 'ProductID']) }} as sales_order_detail_sk,
        
        cast(SalesOrderDetailID as bigint) as sales_order_detail_pk,
        
        cast(SalesOrderID as bigint) as sales_order_fk,
        cast(ProductID as bigint) as product_fk,
        cast(SpecialOfferID as bigint) as special_offer_fk,
        
        cast(OrderQty as bigint) as order_quantity,
        cast(UnitPrice as double) as unit_price,
        cast(UnitPriceDiscount as double) as unit_price_discount,
        
        cast(UnitPrice as double) * cast(OrderQty as bigint) * (1 - cast(UnitPriceDiscount as double)) as line_total,
        
        cast(rowguid as string) as rowguid,
        cast(ModifiedDate as date) as last_updated_at
        
    from source
)

select * from renamed