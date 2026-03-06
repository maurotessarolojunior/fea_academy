with products as (
    select * from {{ ref('int_products_joined') }}
),

final as (
    select
        {{ dbt_utils.generate_surrogate_key(['product_pk']) }} as product_key,
        product_pk,
        product_subcategory_pk,
        product_category_pk,
        product_model_pk,

        -- Product info
        product_name,
        product_number,
        product_color,
        product_size,
        product_weight,
        standard_cost,
        list_price,

        -- Flags
        is_manufactured,
        is_finished_good,

        -- Classification
        subcategory_name,
        category_name,
        model_name

    from products
)

select * from final