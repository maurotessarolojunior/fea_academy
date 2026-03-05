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
        last_name,
        first_name || ' ' || last_name as full_name,
        person_type,

        -- Store info
        store_name,

        -- Address info
        address_pk,
        city,
        postal_code

    from customers
)

select * from final