with products as (
    select * from {{ ref('int_products_joined') }}
),

final as (
    select
        {{ dbt_utils.generate_surrogate_key(['product_pk']) }} as product_key,
        product_pk,
        category_pk,
        subcategory_pk,
        model_pk,

        -- Product info
        product_name,
        product_number,
        color,
        size,
        weight,
        list_price,
        standard_cost,

        -- Classification
        category_name,
        subcategory_name,
        model_name,

        -- Flags
        is_make_flag,
        is_finished_goods_flag,
        product_sell_start_date,
        product_sell_end_date,
        product_discontinued_date,

        -- Metadata
        product_modified_date

    from products
)

select * from final