with
    products as (
        select *
        from {{ ref('stg_advworks__products') }}
    )

    , product_subcategories as (
        select *
        from {{ ref('stg_advworks__product_subcategories') }}
    )

    , product_categories as (
        select *
        from {{ ref('stg_advworks__product_categories') }}
    )

    , product_models as (
        select *
        from {{ ref('stg_advworks__product_models') }}
    )

    , joined as (
        select
            products.product_pk
            , products.product_name
            , products.product_number
            , products.product_color
            , products.product_size
            , products.product_weight
            , products.is_manufactured
            , products.is_finished_good
            , products.standard_cost
            , products.list_price
            , coalesce(product_subcategories.product_subcategory_pk, -1)        as product_subcategory_pk
            , coalesce(product_subcategories.subcategory_name, 'Uncategorized') as subcategory_name
            , coalesce(product_categories.product_category_pk, -1)             as product_category_pk
            , coalesce(product_categories.category_name, 'Uncategorized')      as category_name
            , product_models.product_model_pk
            , coalesce(product_models.model_name, 'No Model')                  as model_name
        from products
        left join product_subcategories on products.product_subcategory_fk = product_subcategories.product_subcategory_pk
        left join product_categories on product_subcategories.product_category_fk = product_categories.product_category_pk
        left join product_models on products.product_model_fk = product_models.product_model_pk
    )

select * from joined