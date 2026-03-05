with source as (
    select * from {{ source('advworks', 'production_product') }}
),

renamed as (
    select
        -- Primary Key
        cast(productid as bigint) as product_pk,
        
        -- Product Info
        cast(name as string) as product_name,
        cast(productnumber as string) as product_number,
        cast(color as string) as product_color,
        cast(size as string) as product_size,
        cast(weight as double) as product_weight,
        
        -- Foreign Keys
        cast(productsubcategoryid as bigint) as product_subcategory_fk,
        cast(productmodelid as bigint) as product_model_fk,
        
        -- Flags
        cast(makeflag as boolean) as is_manufactured,
        cast(finishedgoodsflag as boolean) as is_finished_good,
        
        -- Financial
        cast(standardcost as double) as standard_cost,
        cast(listprice as double) as list_price,
        
        -- Inventory
        cast(safetystocklevel as bigint) as safety_stock_level,
        cast(reorderpoint as bigint) as reorder_point,
        cast(daystomanufacture as bigint) as days_to_manufacture,
        
        -- System columns
        cast(rowguid as string) as rowguid,
        cast(modifieddate as string) as last_updated_at
        
    from source
)

select * from renamed