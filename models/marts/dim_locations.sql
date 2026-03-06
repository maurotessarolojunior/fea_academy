with locations as (
    select * from {{ ref('int_locations_joined') }}
),

final as (
    select
        {{ dbt_utils.generate_surrogate_key(['address_pk']) }} as location_key,
        address_pk,
        state_province_pk,
        country_region_pk,

        -- Address
        address_line_1,
        address_line_2,
        city,
        postal_code,

        -- State/Province
        state_province_name,
        state_province_code,

        -- Country
        country_name

    from locations
)

select * from final