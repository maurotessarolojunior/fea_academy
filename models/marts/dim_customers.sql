with customers as (
    select * from {{ ref('int_customers_joined') }}
),

final as (
    select
        {{ dbt_utils.generate_surrogate_key(['customer_pk']) }} as customer_key,
        customer_pk,
        person_pk,
        store_pk,

        -- Personal info
        first_name,
        middle_name,
        last_name,
        full_name,
        person_type,

        -- Store info
        store_name,

        -- Customer classification
        customer_name,
        customer_type

    from customers
)

select * from final