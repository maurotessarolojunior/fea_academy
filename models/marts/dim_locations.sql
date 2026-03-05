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
        address_line1,
        address_line2,
        city,
        postal_code,

        -- State/Province
        state_province_code,
        state_province_name,
        is_only_state_province_flag,

        -- Country
        country_region_code,
        country_region_name,

        -- Metadata
        address_modified_date

    from locations
)

select * from final