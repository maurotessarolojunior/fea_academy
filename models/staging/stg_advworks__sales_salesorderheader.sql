with source as (
    select * from {{ source('advworks', 'sales_salesorderheader') }}
),

renamed as (
    select
        -- Primary Key
        cast(SalesOrderID as bigint) as sales_order_pk,
        
        -- Foreign Keys
        cast(CustomerID as bigint) as customer_fk,
        cast(CreditCardID as bigint) as credit_card_fk,
        cast(TerritoryID as bigint) as territory_fk,
        cast(SalesPersonID as bigint) as salesperson_fk,
        cast(BillToAddressID as bigint) as bill_to_address_fk,
        cast(ShipToAddressID as bigint) as ship_to_address_fk,
        cast(ShipMethodID as bigint) as ship_method_fk,
        
        -- Dates
        cast(OrderDate as date) as order_date,
        cast(DueDate as date) as due_date,
        cast(ShipDate as date) as ship_date,
        
        -- Status and Flags
        cast(Status as bigint) as order_status,
        cast(OnlineOrderFlag as boolean) as is_online_order,
        
        -- Financial Metrics
        cast(SubTotal as double) as subtotal,
        cast(TaxAmt as double) as tax_amount,
        cast(Freight as double) as freight,
        cast(TotalDue as double) as total_due,
        
        -- System columns
        cast(rowguid as string) as rowguid,
        cast(ModifiedDate as date) as last_updated_at
        
    from source
)

select * from renamed